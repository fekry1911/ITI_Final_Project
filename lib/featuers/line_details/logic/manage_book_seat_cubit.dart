import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:iti_moqaf/featuers/line_details/data/model/stripe_checkout_response.dart';
import 'package:iti_moqaf/featuers/line_details/data/repo/check_out_payment.dart';

import '../../../core/networking/api_result.dart';
import '../data/model/book_response_model.dart';
import '../data/repo/book_cancel_repo.dart';

part 'manage_book_seat_state.dart';

class ManageBookSeatCubit extends Cubit<ManageBookSeatState> {
  final BookAndCancelRepo bookCancelRepo;
  final CheckOutPaymentRepo checkOutPaymentRepo;

  ManageBookSeatCubit(this.bookCancelRepo, this.checkOutPaymentRepo)
    : super(ManageBookSeatInitial());

  bool get _isBusy =>
      state is ManageBookSeatLoading ||
      state is ManageCancelBookSeatLoading ||
      state is ConfirmCheckPaymentLoading ||
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
      print(response.data);
      emit(ManageCancelBookSeatLoaded(response.data));
    } else if (response is ApiError<SeatBookingResponse>) {
      print(response.message);
      emit(ManageCancelBookSeatError(response.message));
    }
  }

  Future<void> confirmBookSeat({
    required String sessionId,
    required String vehicleId,
  }) async {
    if (_isBusy) return;

    emit(ConfirmBookSeatLoading());

    final response = await bookCancelRepo.confirmBookRepo(
      sessionId: sessionId,
    );

    if (response is ApiSuccess<String>) {
      emit(ConfirmBookSeatLoaded(response.data, vehicleId));
    } else if (response is ApiError<String>) {
      emit(ConfirmBookSeatError(response.message));
    }
  }

  Future<void> handleCheckoutPayment({required String bookingId, required String vehicleId}) async {
    if (_isBusy) return;
    emit(ConfirmCheckPaymentLoading());
    final response = await checkOutPaymentRepo.handleCheckoutPayment(
      bookingId: bookingId,
    );
    if (response is ApiSuccess<StripeCheckoutResponse>) {
      emit(ConfirmCheckPaymentLoaded(response.data, vehicleId));
    } else if (response is ApiError<StripeCheckoutResponse>) {
      emit(ConfirmCheckPaymentError(response.message));
    }
  }
}
