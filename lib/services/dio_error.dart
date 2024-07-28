import 'package:dio/dio.dart';

class DioErrorHandler {
  static String handleError(dynamic error) {
    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.cancel:
          return "Request to the server was cancelled";
        case DioErrorType.connectTimeout:
          return "Connection timeout with server";
        case DioErrorType.other:
          return "Connection to the server failed due to internet connection";
        case DioErrorType.receiveTimeout:
          return "Receive timeout in connection with server";
        case DioErrorType.response:
          return "Received invalid status code: ${error.response?.statusCode}";
        case DioErrorType.sendTimeout:
          return "Send timeout in connection with server";
        default:
          return "Unexpected error occurred";
      }
    } else {
      return "Unexpected error occurred";
    }
  }
}
