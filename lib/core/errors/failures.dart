import 'package:dio/dio.dart';

abstract class Failure {
  final String errorMessage;

  Failure(this.errorMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errorMessage);

  factory ServerFailure.fromDioError(DioException dioException){
    switch (dioException.type){

      case DioExceptionType.connectionTimeout:
        return ServerFailure("Connection timeout with ApiServer!");
      case DioExceptionType.sendTimeout:
        return ServerFailure("Send timeout with ApiServer!");
      case DioExceptionType.receiveTimeout:
        return ServerFailure("Receive timeout with ApiServer!");
      case DioExceptionType.badCertificate:
        return ServerFailure("Bad certificate with ApiServer!");
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(dioException.response!.statusCode!, dioException.response!.data);
      case DioExceptionType.cancel:
        return ServerFailure("Request to ApiServer was canceled!");
      case DioExceptionType.connectionError:
        return ServerFailure("Connection error with ApiServer");
      case DioExceptionType.unknown:
        if(dioException.message!.contains('SocketException')) {
          return ServerFailure("No internet connection!");
        }
        return ServerFailure("Unexpected error, please try again!");
      default:
        return ServerFailure("Opps there was an error, Pleas try again!");
    }
  }
  
  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure("Erorr massage 400 401 403");
    } else if (statusCode == 404) {
      return ServerFailure("Your request not Found! please try again later!");
    } else if (statusCode == 500) {
      return ServerFailure("Enternal server error! please try again later!");
    } else {
      return ServerFailure("Opps there was an error, Pleas try again!");
    }
  }
}