import 'package:dio/dio.dart';

sealed class ApiResult {}

class ApiSuccess<T> extends ApiResult {
  final T data;

  ApiSuccess(this.data);
}

class ApiError extends ApiResult {
  final String message;

  ApiError(this.message);
}

String handleDioError(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      return "Connection timed out. Check your internet.";
    case DioExceptionType.receiveTimeout:
      return "Server took too long to respond.";
    case DioExceptionType.badResponse:
      print("RAW SERVER RESPONSE: ${e.response?.data}");
      final statusCode = e.response?.statusCode;
      // Try to parse the error message from the response data
      if (e.response != null && e.response?.data != null) {
        try {
          // Assuming response structure like { "message": "error description" } or { "data": { "message": ... } }
          // The user showed success structure: { "data": { "message": ... } }
          // Let's check common patterns.
          final data = e.response?.data;
          if (data is Map<String, dynamic>) {
            if (data.containsKey('message')) {
              return data['message'];
            }
            if (data.containsKey('data') &&
                data['data'] is Map &&
                data['data'].containsKey('message')) {
              return data['data']['message'];
            }
            if (data.containsKey('error')) {
              return data['error'];
            }
          }
        } catch (error) {
          // Fallback if parsing fails
        }
      }

      if (statusCode == 404) return "Resource not found (404)";
      if (statusCode == 401)
        return "انت غير مسجل"; // Unregistered / Unauthorized
      if (statusCode == 500) return "مشكله ف الاتصال حاول لاحقا";
      if (statusCode == 400) {
        // If we couldn't parse a specific message, 400 could mean many things.
        // Do NOT assume "User already exists". Return a generic bad request or the status text.
        return "بيانات غير صحيحة (400)"; // Invalid data
      }
      return "Received invalid status code: $statusCode";
    case DioExceptionType.cancel:
      return "Request cancelled";
    default:
      return "Network error: ${e.message}";
  }
}
