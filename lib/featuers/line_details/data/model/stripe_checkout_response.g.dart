// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stripe_checkout_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StripeCheckoutResponse _$StripeCheckoutResponseFromJson(
  Map<String, dynamic> json,
) => StripeCheckoutResponse(
  status: json['status'] as String,
  sessionUrl: json['session_url'] as String,
);

Map<String, dynamic> _$StripeCheckoutResponseToJson(
  StripeCheckoutResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'session_url': instance.sessionUrl,
};
