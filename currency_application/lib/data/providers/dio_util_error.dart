import 'dart:io';
import 'package:dio/dio.dart';

import 'app_exceptions.dart';



class DioErrorUtil {
  static handleError(DioError error) {
    String errorDescription = "";
    switch (error.type) {
      case DioErrorType.cancel:
        errorDescription = "Request to server was cancelled";
        break;
      case DioErrorType.connectTimeout:
        throw RequestCanceledException("Connection timeout with server");
      case DioErrorType.other:
        if (error.error is SocketException) {
          throw ConnectionException(
              "Connection to server failed due to internet connection.");
        }
        if (error.response != null) {
          if (401 == error.response!.statusCode) {
            throw UnauthorisedException(
                "Looks like you are unauthorized for this operation. Please login again.");
          } else if (401 < error.response!.statusCode! &&
              error.response!.statusCode! <= 417) {
            throw BadRequestException(
                "Something when wrong. Please try again.");
          } else if (500 <= error.response!.statusCode! &&
              error.response!.statusCode! <= 505) {
            throw ServerSideException(
                "Request can't be handled for now. Please try after sometime.");
          }
        } else {
          throw InvalidInputException(
              "Something went wrong. Please try after sometime.");
        }
        break;
      case DioErrorType.receiveTimeout:
        throw ServerSideException(
            "Request can't be handled for now. Please try after sometime.");
      case DioErrorType.response:
        if (error.response!.statusCode == 12039 ||
            error.response!.statusCode == 12040) {
          throw ConnectionException(
              "Connection to server failed due to internet connection.");
        } else if (401 == error.response!.statusCode) {
          throw UnauthorisedException(
              "Looks like you are unauthorized for this operation. Please login again.");
        } else if (401 < error.response!.statusCode! &&
            error.response!.statusCode! <= 417) {
          throw BadRequestException("Something when wrong. Please try again.");
        } else if (500 <= error.response!.statusCode! &&
            error.response!.statusCode! <= 505) {
          throw ServerSideException(
              "Request can't be handled for now. Please try after sometime.");
        } else {
          throw InvalidInputException(
              "Something went wrong. Please try after sometime.");
        }
      case DioErrorType.sendTimeout:
        throw ServerSideException(
            "Request can't be handled for now. Please try after sometime.");
      default:
        throw InvalidInputException(
            "Something went wrong. Please try after sometime.");
    }
    return errorDescription;
  }
}
