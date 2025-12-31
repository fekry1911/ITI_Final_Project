part of 'manage_book_seat_cubit.dart';


@immutable
sealed class ManageBookSeatState extends Equatable {}

final class ManageBookSeatInitial extends ManageBookSeatState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class ManageBookSeatLoading extends ManageBookSeatState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class ManageBookSeatLoaded extends ManageBookSeatState {
  final SeatBookingResponse seatBookingResponse;
  ManageBookSeatLoaded(this.seatBookingResponse);
  @override
  // TODO: implement props
  List<Object?> get props => [seatBookingResponse];
}

final class ManageBookSeatError extends ManageBookSeatState {
  final String message;
  ManageBookSeatError(this.message);
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
final class ManageCancelBookSeatLoading extends ManageBookSeatState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class ManageCancelBookSeatLoaded extends ManageBookSeatState {
  final SeatBookingResponse seatBookingResponse;
  ManageCancelBookSeatLoaded(this.seatBookingResponse);
  @override
  // TODO: implement props
  List<Object?> get props => [seatBookingResponse];
}

final class ManageCancelBookSeatError extends ManageBookSeatState {
  final String message;
  ManageCancelBookSeatError(this.message);
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

final class ConfirmBookSeatLoading extends ManageBookSeatState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class ConfirmBookSeatLoaded extends ManageBookSeatState {
  final String meesage;
  String vehicleId;
  ConfirmBookSeatLoaded(this.meesage,this.vehicleId);
  @override
  // TODO: implement props
  List<Object?> get props => [meesage,vehicleId];
}

final class ConfirmBookSeatError extends ManageBookSeatState {
  final String meesage;
  ConfirmBookSeatError(this.meesage);
  @override
  // TODO: implement props
  List<Object?> get props => [meesage];
}

final class Done extends ManageBookSeatState {

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
final class ConfirmCheckPaymentLoading extends ManageBookSeatState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class ConfirmCheckPaymentLoaded extends ManageBookSeatState {
  final StripeCheckoutResponse data;
  final String vehicleId;
  ConfirmCheckPaymentLoaded(this.data,this.vehicleId);
  @override
  // TODO: implement props
  List<Object?> get props => [data,vehicleId];
}

final class ConfirmCheckPaymentError extends ManageBookSeatState {
  final String meesage;
  ConfirmCheckPaymentError(this.meesage);
  @override
  // TODO: implement props
  List<Object?> get props => [meesage];
}