import 'package:dio/dio.dart';

abstract class Failure {
  final String errorMessage;

  Failure(this.errorMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errorMessage);

  factory ServerFailure.fromDioError(DioError dioException){
    switch (dioException.type){

      case DioErrorType.connectTimeout:
        return ServerFailure("Connection timeout with ApiServer!");
      case DioErrorType.sendTimeout:
        return ServerFailure("Send timeout with ApiServer!");
      case DioErrorType.receiveTimeout:
        return ServerFailure("Receive timeout with ApiServer!");
      case DioErrorType.response:
        return ServerFailure.fromResponse(dioException.response!.statusCode!, dioException.response!.data);
      case DioErrorType.cancel:
        return ServerFailure("Request to ApiServer was canceled!");
      case DioErrorType.other:
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