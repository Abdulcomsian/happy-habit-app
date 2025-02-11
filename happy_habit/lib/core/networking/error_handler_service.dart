import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

import '../services/logger.dart';
import 'networking_models.dart';

class CustomTryCatch {
  static T? run<T>({required String label, required Function block}) {
    try {
      return block();
    } catch (e) {
      final error = CustomExceptionHandler.handleException(e, label: label);
      Logger.logError('Error on: $label');
      Logger.logError('${error.type}: ${error.message}');

      return null;
    }
  }
}

class CustomExceptionHandler {
  static ApiResponseGeneric handleException(dynamic e, {required String label}) {
    if (e is FileSystemException) {
      return _handleFileSystemException(e, label);
    } else if (e is PlatformException) {
      return _handlePlatformException(e, label);
    } else if (e is SocketException) {
      return _handleSocketException(e, label);
    } else if (e is TimeoutException) {
      return _handleTimeoutException(e, label);
    } else if (e is TypeError || e.toString() == '_TypeError') {
      return _handleTypeError(e, label);
    } else if (e is DioException) {
      return _handleDioError(e, label);
    } else {
      return ApiResponseGeneric(
        success: false,
        type: 'UnknownError',
        message: "Something went wrong. Error code: UNKNOWN_ERR",
      );
    }
  }

  static ApiResponseGeneric _handleTypeError(TypeError typeError, String label) {
    return ApiResponseGeneric(
      success: false,
      type: 'TypeError',
      message: typeError.toString(),
    );
  }

  static ApiResponseGeneric _handleDioError(DioException e, String label) {
    String errType = e.error.runtimeType.toString();

    Logger.logError('Its a dio error of type: $errType');
    Logger.logError('${e.type}******');
    Logger.logError('${e.response}');
    if (errType == "HttpException") {
      return _handleSocketException(e, label);
    }

    if (e.type == DioExceptionType.badResponse &&
        e.response != null &&
        e.response!.data != null &&
        e.response!.data is Map &&
        e.response!.data['message'] != null) {
      try {
        final String message = e.response!.data['message'];

        return ApiResponseGeneric(
          success: false,
          message: message,
          code: e.response!.statusCode,
          data: e.response!.data['data'] ?? e.response!.data,
        );
      } catch (e) {
        Logger.logError('_handleDioError()=> $e');
        return ApiResponseGeneric(
          message: "Something went wrong. Error code: DATA_PARSE_ERR",
        );
      }
    } else {
      return ApiResponseGeneric(
        type: 'CustomException',
        message: "Something went wrong. Error code: UNKNOWN_ERR",
      );
    }
  }

  static ApiResponseGeneric _handleFileSystemException(
      FileSystemException systemException, String label) {
    return ApiResponseGeneric(
      type: 'FileSystemException',
      message: "File System Error: ${systemException.message}.",
    );
  }

  static ApiResponseGeneric _handlePlatformException(
      PlatformException platformException, String label) {
    return ApiResponseGeneric(
      type: 'PlatformException',
      message: "Platform Error: ${platformException.message!}.",
    );
  }

  static ApiResponseGeneric _handleSocketException(var socketException, String label) {
    return ApiResponseGeneric(
      success: false,
      type: 'SocketException',
      message: "Looks like you’re offline. Please check your internet connection and try again",
    );
  }

  static ApiResponseGeneric _handleTimeoutException(
      TimeoutException socketException, String label) {
    return ApiResponseGeneric(
      type: 'TimeoutException',
      message: "This took longer than expected. Please try again",
    );
  }
}
