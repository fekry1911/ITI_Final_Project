import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_moqaf/core/const/const_paths.dart';
import 'package:iti_moqaf/core/helpers/cach_helper.dart';
import 'package:iti_moqaf/core/helpers/extentions/context_extentions.dart';
import 'package:iti_moqaf/core/shared_widgets/toast.dart';
import 'package:iti_moqaf/core/theme/color/colors.dart';
import 'package:iti_moqaf/core/theme/text_theme/text_theme.dart';
import 'package:iti_moqaf/featuers/line_details/logic/manage_book_seat_cubit.dart';
import 'package:iti_moqaf/featuers/line_details/screen/widgets/payment_view.dart';

import '../../data/model/microbus_models.dart';
import '../../logic/get_details_of_line_cubit.dart';
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
        if (current is ConfirmCheckPaymentLoading) {
          return true;
        }
        if (current is ManageBookSeatLoaded) {
          return current.seatBookingResponse.data!.vehicle.id == bus.id;
        }
        if (current is ManageCancelBookSeatLoaded) {
          print("${current.seatBookingResponse.data!.vehicle.id} + ${bus.id}");
          print("${current.seatBookingResponse.data!.vehicle.id} + ${bus.id}");
          print("${current.seatBookingResponse.data!.vehicle.id} + ${bus.id}");
          print("${current.seatBookingResponse.data!.vehicle.id} + ${bus.id}");
          print("${current.seatBookingResponse.data!.vehicle.id} + ${bus.id}");
          print("${current.seatBookingResponse.data!.vehicle.id} + ${bus.id}");
          print("${current.seatBookingResponse.data!.vehicle.id} + ${bus.id}");
          print("${current.seatBookingResponse.data!.vehicle.id} + ${bus.id}");
          print("${current.seatBookingResponse.data!.vehicle.id} + ${bus.id}");
          print("${current.seatBookingResponse.data!.vehicle.id} + ${bus.id}");
          print("${current.seatBookingResponse.data!.vehicle.id} + ${bus.id}");
          print("${current.seatBookingResponse.data!.vehicle.id} + ${bus.id}");
          print("${current.seatBookingResponse.data!.vehicle.id} + ${bus.id}");
          print("${current.seatBookingResponse.data!.vehicle.id} + ${bus.id}");
          print("${current.seatBookingResponse.data!.vehicle.id} + ${bus.id}");
          print("${current.seatBookingResponse.data!.vehicle.id} + ${bus.id}");
          print("${current.seatBookingResponse.data!.vehicle.id} + ${bus.id}");
          print("${current.seatBookingResponse.data!.vehicle.id} + ${bus.id}");
          print("${current.seatBookingResponse.data!.vehicle.id} + ${bus.id}");
          print("${current.seatBookingResponse.data!.vehicle.id} + ${bus.id}");
          print("${current.seatBookingResponse.data!.vehicle.id} + ${bus.id}");
          print("${current.seatBookingResponse.data!.vehicle.id} + ${bus.id}");
          print("${current.seatBookingResponse.data!.vehicle.id} + ${bus.id}");
          print("${current.seatBookingResponse.data!.vehicle.id} + ${bus.id}");
          print("${current.seatBookingResponse.data!.vehicle.id} + ${bus.id}");
          print("${current.seatBookingResponse.data!.vehicle.id} + ${bus.id}");
          print("${current.seatBookingResponse.data!.vehicle.id} + ${bus.id}");
          print("${current.seatBookingResponse.data!.vehicle.id} + ${bus.id}");

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
        if (state is ManageBookSeatLoading) {}
        if (state is ManageBookSeatLoaded) {
          final booking = state.seatBookingResponse.data;
          sucssesToast(
            context,
            "عملية حجز ناجحة",
            "يرجى تأكيد الحجز خلال 10 دقائق",
          );
          cubitLines.updateVehicleAfterBooking(
            vehicleId: bus.id,
            newBookedUser: BookedUser(
              id: booking!.user.id,
              firstName: booking!.user.firstName,
              lastName: booking!.user.lastName,
              email: booking!.user.email,
              bookingStatus: booking!.status,
              bookingId: booking!.id,
              bookedAt: booking!.createdAt,
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
          final result = await Navigator.of(context).push<String>(
            MaterialPageRoute(builder: (_) => WebViewScreen(url: sessionUrl)),
          );
          if (result == null) {
            errorToast(
              context,
              "فشل العملية",
              "تم إلغاء الدفع أو العملية غير مكتملة",
            );
          } else if (result.startsWith("error:")) {
            final errorMessage = result.replaceFirst("error:", "");
            errorToast(context, "فشل العملية", errorMessage);
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

          String statusText = bus.currentStatus;
          Color statusColor = const Color(0xFFE8F5E9);
          Color statusTextColor = const Color(0xFF43A047);

          if (isFull) {
            statusText = "FULL";
            statusColor = const Color(0xFFFFEBEE);
            statusTextColor = const Color(0xFFE53935);
          } else if (isBusy) {
            statusText = "Busy";
            statusColor = const Color(0xFFFFF3E0);
            statusTextColor = const Color(0xFFFB8C00);
          }

          final manageCubit = context.read<ManageBookSeatCubit>();

          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          statusText,
                          style: TextStyle(
                            color: statusTextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "• ${currentBus.isAirConditioned
                              ? "AC"
                              : "Non-AC"} • On Time",
                          textAlign: TextAlign.end,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  /// Bus Info

                      Row(
                        children: [
                          Text(
                            "Bus ${currentBus.plateNumber}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                        ],
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "${currentBus.lines[0].fromStation
                            .stationName} - ${currentBus.lines[0].toStation
                            .stationName}",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                  Row(
                    children: [
                      Icon(Icons.location_on,size: 15.r,color:Colors.green,),
                      Text(
                        "${currentBus.currentStation.stationName}",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    ],
                  ),



                  const SizedBox(height: 16),

                  /// Capacity
                  Text(
                    "${currentBus.capacity -
                        currentBus.availableSeats} / ${currentBus.capacity}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  LinearProgressIndicator(
                    value:
                    (currentBus.capacity - currentBus.availableSeats) /
                        currentBus.capacity,
                    backgroundColor: Colors.grey[200],
                  ),

                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),

                  /// Actions
                  Row(
                    children: [
                      CircleAvatar(
                          backgroundColor: Colors.grey[200],
                          radius: 15.r, child: Icon(Icons.person)),
                      const SizedBox(width: 8),

                      Expanded(
                        child: Text(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          bus.driverName,
                          style: AppTextStyle.font9BlackRegular,
                        ),
                      ),
                      const Spacer(),

                      if (CacheHelper.sharedPreferences!.getString("token") ==
                          null)
                        buildButton(
                          text: "يجب تسجيل الدخول اولا",
                          color: AppColors.mainColor,
                          onTap: () {
                            context.pushNamed(loginScreen);
                          },
                        )
                      else
                        if (bookingStatus == null)
                          buildButton(
                            text: "أحجز",
                            color: AppColors.mainColor,
                            onTap: () {
                              // تحديث فوري (Optimistic Update)
                              if (user != null && userId != null) {
                                final cubitLines = context
                                    .read<GetDetailsOfLineCubit>();
                                cubitLines.updateVehicleAfterBooking(
                                  vehicleId: currentBus.id,
                                  newBookedUser: BookedUser(
                                    id: userId,
                                    firstName: user.firstName ?? '',
                                    lastName: user.lastName ?? '',
                                    email: user.email ?? '',
                                    bookingStatus: "pending",
                                    bookingId:
                                    "temp_${DateTime
                                        .now()
                                        .millisecondsSinceEpoch}",
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
                          )
                        else
                          if (bookingStatus == "pending")
                            Row(
                              children: [
                                buildButton(
                                  text: "إلغاء",
                                  color: AppColors.redColor,
                                  onTap: () {
                                    // تحديث فوري (Optimistic Update)
                                    if (userId != null) {
                                      final cubitLines = context
                                          .read<GetDetailsOfLineCubit>();
                                      cubitLines.updateVehicleAfterCancel(
                                        vehicleId: currentBus.id,
                                        userId: userId,
                                      );
                                    }
                                    // استدعاء API في الخلفية
                                    manageCubit.cancelBookSeat(
                                      vehicleId: currentBus.id,
                                      lineId: lineId,
                                      stationId: stationId,
                                    );
                                  },
                                ),
                                SizedBox(width: 6.w),
                                buildButton(
                                  text: "تأكيد",
                                  color: Colors.grey,
                                  onTap: () {
                                    manageCubit.handleCheckoutPayment(
                                      vehicleId: currentBus.id,
                                      bookingId: bookedUser!.bookingId,
                                    );
                                    // تحديث فوري (Optimistic Update)
                                    /*  if (userId != null) {
                                  final cubitLines = context
                                      .read<GetDetailsOfLineCubit>();
                                  cubitLines.updateStatusOfBooking(
                                    vehicleId: currentBus.id,
                                    userId: userId,
                                    status: "confirmed",
                                  );*/
                                    // }
                                  },
                                ),
                              ],
                            )
                          else
                            Row(
                              children: [
                                buildButton(
                                  text: "إلغاء",
                                  color: AppColors.redColor,
                                  onTap: () {
                                    if (userId != null) {
                                      final cubitLines = context
                                          .read<GetDetailsOfLineCubit>();
                                      cubitLines.updateVehicleAfterCancel(
                                        vehicleId: currentBus.id,
                                        userId: userId,
                                      );
                                    }
                                    manageCubit.cancelBookSeat(
                                      vehicleId: currentBus.id,
                                      lineId: lineId,
                                      stationId: stationId,
                                    );
                                  },
                                ),
                                SizedBox(width: 6.w),
                                buildButton(
                                  text: "نشطة",
                                  color: Colors.green,
                                  onTap: () {},
                                ),
                              ],
                            ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

}
