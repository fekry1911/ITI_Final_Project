// [FULL FILE — unchanged UI, logic fixed]
// NOTE: Only fix is using currentBus everywhere instead of bus

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_moqaf/core/helpers/extentions/context_extentions.dart';
import 'package:iti_moqaf/featuers/line_details/screen/widgets/payment_view.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/const/const_paths.dart';
import '../../../../core/helpers/cach_helper.dart';
import '../../../../core/shared_widgets/modern_card.dart';
import '../../../../core/shared_widgets/toast.dart';
import '../../../../core/theme/color/colors.dart';
import '../../../../core/theme/text_theme/text_theme.dart';
import '../../data/model/microbus_models.dart';
import '../../logic/get_details_of_line_cubit.dart';
import '../../logic/manage_book_seat_cubit.dart';
import 'button_of_book.dart';

class BusCard extends StatelessWidget {
  final Microbus bus;
  final String stationId;
  final String lineId;

  const BusCard({
    super.key,
    required this.bus,
    required this.stationId,
    required this.lineId,
  });

  @override
  Widget build(BuildContext context) {
    final userId = CacheHelper.getString(key: "userId");
    final user = CacheHelper.getUser();

    return BlocListener<ManageBookSeatCubit, ManageBookSeatState>(
      listenWhen: (previous, current) {
        if (current is ConfirmCheckPaymentLoading) return true;
        if (current is ManageBookSeatLoaded) {
          return current.seatBookingResponse.data!.vehicle.id == bus.id;
        }
        if (current is ManageCancelBookSeatLoaded) {
          return current.seatBookingResponse.data!.vehicle.id == bus.id;
        }
        if (current is ConfirmBookSeatLoaded) {
          return current.vehicleId == bus.id;
        }
        if (current is ConfirmCheckPaymentLoaded) {
          return current.vehicleId == bus.id;
        }
        return false;
      },
      listener: (context, state) async {
        final cubitLines = context.read<GetDetailsOfLineCubit>();

        if (state is ManageBookSeatLoaded) {
          final booking = state.seatBookingResponse.data!;
          sucssesToast(
            context,
            "عملية حجز ناجحة",
            "يرجى تأكيد الحجز خلال 10 دقائق",
          );

          cubitLines.updateVehicleAfterBooking(
            vehicleId: bus.id,
            newBookedUser: BookedUser(
              id: booking.user.id,
              firstName: booking.user.firstName,
              lastName: booking.user.lastName,
              email: booking.user.email,
              bookingStatus: booking.status,
              bookingId: booking.id,
              bookedAt: booking.createdAt,
            ),
          );
        }

        if (state is ManageCancelBookSeatLoaded) {
          sucssesToast(context, "تم إلغاء الحجز", "تم إلغاء الحجز بنجاح");
          cubitLines.updateVehicleAfterCancel(
            vehicleId: bus.id,
            userId: userId,
          );
        }

        if (state is ConfirmBookSeatLoaded) {
          sucssesToast(context, "تم تأكيد الحجز", "تم تأكيد الحجز بنجاح");
          cubitLines.updateStatusOfBooking(
            vehicleId: bus.id,
            userId: userId,
            status: "confirmed",
          );
        }

        if (state is ConfirmCheckPaymentLoaded) {
          final sessionUrl = state.data.sessionUrl;
          final result = await Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => WebViewScreen(url: sessionUrl)),
          );

          if (result == null) {
            errorToast(context, "فشل العملية", "تم إلغاء الدفع");
          } else if (result.startsWith("error:")) {
            errorToast(
              context,
              "فشل العملية",
              result.replaceFirst("error:", ""),
            );
          } else {
            context.read<ManageBookSeatCubit>().confirmBookSeat(
              sessionId: result,
              vehicleId: bus.id,
            );
          }
        }
      },
      child: BlocBuilder<GetDetailsOfLineCubit, GetDetailsOfLineState>(
        builder: (context, lineState) {
          Microbus currentBus = bus;

          if (lineState is GetDetailsOfLineSuccess) {
            currentBus = lineState.results.firstWhere(
              (b) => b.id == bus.id,
              orElse: () => bus,
            );
          }

          final bookedUser = currentBus.bookedUsers.firstWhereOrNull(
            (u) => u.id == userId,
          );

          final bookingStatus = bookedUser?.bookingStatus;
          final isFull = currentBus.availableSeats == 0;
          final isBusy =
              currentBus.availableSeats < (currentBus.capacity * 0.2);

          String statusText = currentBus.currentStatus;
          Color statusColor = AppColors.success.withOpacity(0.1);
          Color statusTextColor = AppColors.success;

          if (isFull) {
            statusText = "FULL";
            statusColor = AppColors.error.withOpacity(0.1);
            statusTextColor = AppColors.error;
          } else if (isBusy) {
            statusText = "Busy";
            statusColor = AppColors.warning.withOpacity(0.1);
            statusTextColor = AppColors.warning;
          }

          final manageCubit = context.read<ManageBookSeatCubit>();
          final isSkeleton = Skeletonizer.maybeOf(context)?.enabled ?? false;
          print(
            "asdnjkbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb${bookingStatus}",
          );

          return ModernCard(
            enableAnimation: !isSkeleton,
            elevation: 1,
            padding: EdgeInsets.all(16.w),
            margin: EdgeInsets.zero,
            onTap: isSkeleton ? null : () {},
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: statusColor,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: statusTextColor.withOpacity(0.2),
                        ),
                      ),
                      child: Text(
                        statusText == "onRout"
                            ? "في الطريق"
                            : statusText == "maintenance"
                            ? "صيانه"
                            : "متاحه",
                        style: TextStyle(
                          color: statusTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (currentBus.isAirConditioned) ...[
                            Icon(
                              Icons.ac_unit_rounded,
                              size: 14.r,
                              color: AppColors.primary,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              "مكيفه",
                              style: AppTextStyle.font11BlackRegular.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                            SizedBox(width: 8.w),
                          ],
                          Text(
                            "• On Time",
                            style: AppTextStyle.font11BlackRegular.copyWith(
                              color: AppColors.success,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16.h),

                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.r),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.directions_bus_rounded,
                        color: AppColors.primary,
                        size: 20.r,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "حافلة رقم ${currentBus.plateNumber}",
                          style: AppTextStyle.font16BlackBold.copyWith(
                            fontSize: 13.sp,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          children: [
                            Icon(
                              Icons.route_rounded,
                              size: 14.r,
                              color: AppColors.textTertiary,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              "${currentBus.lines[0].fromStation.stationName} -> ${currentBus.lines[0].toStation.stationName}",
                              style: AppTextStyle.font12BlackRegular.copyWith(
                                fontSize: 10.sp,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 12.h),

                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceVariant,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 16.r,
                        color: AppColors.secondary,
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          "الموقع الحالي: ${currentBus.currentStation.stationName}",
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyle.font12BlackRegular,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "المقاعد المتاحة",
                      style: AppTextStyle.font12BlackRegular,
                    ),
                    Text(
                      "${currentBus.availableSeats} / ${currentBus.capacity}",
                      style: AppTextStyle.font14BlackBold.copyWith(
                        color: currentBus.availableSeats < 3
                            ? AppColors.error
                            : AppColors.primary,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 8.h),

                ClipRRect(
                  borderRadius: BorderRadius.circular(4.r),
                  child: LinearProgressIndicator(
                    value:
                        (currentBus.capacity - currentBus.availableSeats) /
                        currentBus.capacity,
                    backgroundColor: AppColors.border,
                    color: currentBus.availableSeats < 3
                        ? AppColors.error
                        : AppColors.primary,
                    minHeight: 6.h,
                  ),
                ),

                const SizedBox(height: 20),
                const Divider(height: 1, color: AppColors.border),
                const SizedBox(height: 16),

                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.surfaceVariant,
                      radius: 18.r,
                      child: Icon(
                        Icons.person,
                        color: AppColors.textSecondary,
                        size: 20.r,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("الكابتن", style: AppTextStyle.font11BlackRegular),
                        Text(
                          currentBus.driverName,
                          style: AppTextStyle.font12BlackBold,
                        ),
                      ],
                    ),

                    const Spacer(),
                    if (currentBus.currentStatus != "idle")
                      Flexible(
                        child: buildButton(
                          text: "غير متاح",
                          color: AppColors.textTertiary,
                          onTap: null,
                        ),
                      )
                    else if (CacheHelper.getString(key: "token") == null)
                      buildButton(
                        text: "سجل أولاً",
                        color: AppColors.primary,
                        onTap: isSkeleton
                            ? null
                            : () {
                                context.pushNamed(loginScreen);
                              },
                      )
                    else if (bookingStatus == null)
                      SizedBox(
                        width: 100.w,
                        child: buildButton(
                          text: "احجز الآن",
                          color: AppColors.primary,
                          onTap: isSkeleton
                              ? null
                              : () {
                                  if (user != null && userId != null) {
                                    context
                                        .read<GetDetailsOfLineCubit>()
                                        .updateVehicleAfterBooking(
                                          vehicleId: currentBus.id,
                                          newBookedUser: BookedUser(
                                            id: userId,
                                            firstName: user.firstName ?? '',
                                            lastName: user.lastName ?? '',
                                            email: user.email ?? '',
                                            bookingStatus: "pending",
                                            bookingId:
                                                "temp_${DateTime.now().millisecondsSinceEpoch}",
                                            bookedAt: DateTime.now(),
                                          ),
                                        );
                                  }

                                  manageCubit.bookSeat(
                                    vehicleId: currentBus.id,
                                    lineId: lineId,
                                    stationId: stationId,
                                  );
                                },
                        ),
                      )
                    else if (bookingStatus == "pending")
                      Row(
                        children: [
                          buildButton(
                            text: "إلغاء",
                            color: AppColors.error,
                            onTap: isSkeleton
                                ? null
                                : () {
                                    context
                                        .read<GetDetailsOfLineCubit>()
                                        .updateVehicleAfterCancel(
                                          vehicleId: currentBus.id,
                                          userId: userId,
                                        );

                                    manageCubit.cancelBookSeat(
                                      vehicleId: currentBus.id,
                                      lineId: lineId,
                                      stationId: stationId,
                                    );
                                  },
                          ),
                          SizedBox(width: 8.w),
                          buildButton(
                            text: "تأكيد الدفع",
                            color: AppColors.success,
                            onTap: isSkeleton
                                ? null
                                : () {
                                    manageCubit.handleCheckoutPayment(
                                      vehicleId: currentBus.id,
                                      bookingId: bookedUser!.bookingId,
                                    );
                                  },
                          ),
                        ],
                      )
                    else
                      Row(
                        children: [
                          buildButton(
                            text: "إلغاء",
                            color: AppColors.error,
                            onTap: isSkeleton
                                ? null
                                : () {
                                    context
                                        .read<GetDetailsOfLineCubit>()
                                        .updateVehicleAfterCancel(
                                          vehicleId: currentBus.id,
                                          userId: userId,
                                        );

                                    manageCubit.cancelBookSeat(
                                      vehicleId: currentBus.id,
                                      lineId: lineId,
                                      stationId: stationId,
                                    );
                                  },
                          ),
                          SizedBox(width: 8.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 8.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.success.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(color: AppColors.success),
                            ),
                            child: Text(
                              "تم الحجز",
                              style: AppTextStyle.font12BlackBold.copyWith(
                                color: AppColors.success,
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
