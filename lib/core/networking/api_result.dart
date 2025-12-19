import 'package:dio/dio.dart';

sealed class ApiResult<T>{}

class ApiSuccess<T> extends ApiResult<T>{
  final T data;

  ApiSuccess(this.data);
}

class ApiError<T> extends ApiResult<T>{
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
      final statusCode = e.response?.statusCode;
      if (statusCode == 404) return "Resource not found (404)";
      if (statusCode == 401) return "انت غير مسجل";
      if (statusCode == 500) return "مشكله ف الاتصال حاول لاحقا";
      if (statusCode == 400) return "المستحدم موجود بالفغل";
      return "Received invalid status code: $statusCode";
    case DioExceptionType.cancel:
      return "Request cancelled";
    default:
      return "Network error: ${e.message}";
  }
}
