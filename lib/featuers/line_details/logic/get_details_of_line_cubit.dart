import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:iti_moqaf/core/networking/api_result.dart';
import 'package:iti_moqaf/featuers/line_details/data/repo/get_line_details_repo.dart';
import '../data/model/microbus_models.dart';

part 'get_details_of_line_state.dart';

class GetDetailsOfLineCubit extends Cubit<GetDetailsOfLineState> {
  final GetLineDetailsRepo getLineDetailsRepo;

  GetDetailsOfLineCubit(this.getLineDetailsRepo)
      : super(GetDetailsOfLineInitial());

  Future<void> getLineDetails(String lineId, String stationId) async {
    emit(GetDetailsOfLineLoading());

    final result =
    await getLineDetailsRepo.getLineDetails(lineId, stationId);

    if (result is ApiSuccess<MicrobusResponse>) {
      emit(GetDetailsOfLineSuccess(result.data.results));
    } else if (result is ApiError<MicrobusResponse>) {
      emit(GetDetailsOfLineError(result.message));
    }
  }

  /// ✅ تأكيد الحجز (pending -> confirmed)
  void updateStatusOfBooking({
    required String vehicleId,
    required String userId,
    required String status,
  }) {
    if (state is! GetDetailsOfLineSuccess) return;

    final currentState = state as GetDetailsOfLineSuccess;

    final updatedBuses = currentState.results.map((bus) {
      if (bus.id != vehicleId) return bus;

      final updatedUsers = bus.bookedUsers.map((user) {
        if (user.id == userId) {
          return user.copyWith(bookingStatus: status);
        }
        return user;
      }).toList();

      return bus.copyWith(bookedUsers: updatedUsers);
    }).toList();

    emit(
      GetDetailsOfLineSuccess(
        updatedBuses,
        version: currentState.version + 1,
      ),
    );
  }

  /// ✅ بعد الحجز
  void updateVehicleAfterBooking({
    required String vehicleId,
    required BookedUser newBookedUser,
  }) {
    if (state is! GetDetailsOfLineSuccess) return;

    final currentState = state as GetDetailsOfLineSuccess;

    final updatedBuses = currentState.results.map((bus) {
      if (bus.id != vehicleId) return bus;

      // التحقق من وجود المستخدم لتجنب التكرار
      final existingUserIndex = bus.bookedUsers.indexWhere(
        (u) => u.id == newBookedUser.id,
      );

      final updatedUsers = existingUserIndex >= 0
          ? bus.bookedUsers.map((user) {
              if (user.id == newBookedUser.id) {
                return newBookedUser; // استبدال المستخدم الموجود
              }
              return user;
            }).toList()
          : [...bus.bookedUsers, newBookedUser]; // إضافة مستخدم جديد

      // تحديث المقاعد المتاحة فقط إذا كان المستخدم جديداً
      final shouldDecrementSeats = existingUserIndex < 0;

      return bus.copyWith(
        bookedUsers: updatedUsers,
        availableSeats: shouldDecrementSeats && bus.availableSeats > 0
            ? bus.availableSeats - 1
            : bus.availableSeats,
      );
    }).toList();

    emit(
      GetDetailsOfLineSuccess(
        updatedBuses,
        version: currentState.version + 1,
      ),
    );
  }

  /// ✅ إلغاء الحجز
  void updateVehicleAfterCancel({
    required String vehicleId,
    required String userId,
  }) {
    if (state is! GetDetailsOfLineSuccess) return;

    final currentState = state as GetDetailsOfLineSuccess;

    final updatedBuses = currentState.results.map((bus) {
      if (bus.id != vehicleId) return bus;

      return bus.copyWith(
        bookedUsers:
        bus.bookedUsers.where((u) => u.id != userId).toList(),
        availableSeats: bus.availableSeats < bus.capacity
            ? bus.availableSeats + 1
            : bus.availableSeats,
      );
    }).toList();

    emit(
      GetDetailsOfLineSuccess(
        updatedBuses,
        version: currentState.version + 1,
      ),
    );
  }
}
