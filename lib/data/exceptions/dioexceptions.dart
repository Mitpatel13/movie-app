import 'package:dio/dio.dart';

class DioExceptions implements Exception {
  late String message;

  DioExceptions.fromDioError(DioError dioError) {
    switch (dioError.type) {

      case DioErrorType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;


      case DioErrorType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;

      default:
        message = "Something went wrong";
        break;
    }
  }

  String _handleError(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return 'The otp is incorrect';
      case 401:
        return 'Unauthorized';
      case 403:
        return 'Forbidden';
      case 404:
        return 'message';
      case 500:
        return 'Internal server error';
      case 502:
        return 'Bad gateway';
      default:
      // return error['message'];

        return 'User already exists Please use different number';
    }
  }

  @override
  String toString() => message;
}

