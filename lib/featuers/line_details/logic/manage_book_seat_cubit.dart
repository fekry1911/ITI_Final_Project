import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import '../../../core/networking/api_result.dart';
import '../data/model/book_response_model.dart';
import '../data/repo/book_cancel_repo.dart';

part 'manage_book_seat_state.dart';

class ManageBookSeatCubit extends Cubit<ManageBookSeatState> {
  final BookAndCancelRepo bookCancelRepo;

  ManageBookSeatCubit(this.bookCancelRepo)
      : super(ManageBookSeatInitial());

  bool get _isBusy =>
      state is ManageBookSeatLoading ||
          state is ManageCancelBookSeatLoading ||
          state is ConfirmBookSeatLoading;

  Future<void> bookSeat({
    required String vehicleId,
    required String lineId,
    required String stationId,
  }) async {
    if (_isBusy) return;

    emit(ManageBookSeatLoading());

    final response = await bookCancelRepo.bookSeatRepo(
      vehicleId: vehicleId,
      lineId: lineId,
      stationId: stationId,
    );

    if (response is ApiSuccess<SeatBookingResponse>) {
      emit(ManageBookSeatLoaded(response.data));
    } else if (response is ApiError<SeatBookingResponse>) {
      emit(ManageBookSeatError(response.message));
    }
  }

  Future<void> cancelBookSeat({
    required String vehicleId,
    required String lineId,
    required String stationId,
  }) async {
    if (_isBusy) return;

    emit(ManageCancelBookSeatLoading());

    final response = await bookCancelRepo.cancelBookSeatRepo(
      vehicleId: vehicleId,
      lineId: lineId,
      stationId: stationId,
    );

    if (response is ApiSuccess<SeatBookingResponse>) {
      emit(ManageCancelBookSeatLoaded(response.data));
    } else if (response is ApiError<SeatBookingResponse>) {
      emit(ManageCancelBookSeatError(response.message));
    }
  }

  Future<void> confirmBookSeat({
    required String vehicleId,
    required String lineId,
    required String stationId,
    required String bookingId,
  }) async {
    if (_isBusy) return;

    emit(ConfirmBookSeatLoading());

    final response = await bookCancelRepo.confirmBookRepo(
      vehicleId: vehicleId,
      lineId: lineId,
      stationId: stationId,
      bookingId: bookingId,
    );

    if (response is ApiSuccess<String>) {
      emit(ConfirmBookSeatLoaded(response.data, vehicleId));
    } else if (response is ApiError<String>) {
      emit(ConfirmBookSeatError(response.message));
    }
  }
}
