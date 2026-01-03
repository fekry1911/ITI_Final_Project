
import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/api_service.dart';
import '../model/stripe_checkout_response.dart';

class CheckOutPaymentRepo {
  ApiService apiService;

  CheckOutPaymentRepo(this.apiService);

  Future<ApiResult<StripeCheckoutResponse>> handleCheckoutPayment({
    required String bookingId,
  }) => apiService.handleCheckoutPayment(bookingId: bookingId);
}
