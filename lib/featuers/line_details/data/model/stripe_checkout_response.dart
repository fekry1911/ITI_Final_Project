import 'package:json_annotation/json_annotation.dart';

part 'stripe_checkout_response.g.dart';

@JsonSerializable()
class StripeCheckoutResponse {
  final String status;
  @JsonKey(name: 'session_url')
  final String sessionUrl;

  StripeCheckoutResponse({
    required this.status,
    required this.sessionUrl,
  });

  factory StripeCheckoutResponse.fromJson(Map<String, dynamic> json) =>
      _$StripeCheckoutResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StripeCheckoutResponseToJson(this);
}