import 'dart:io';

import 'package:dio/dio.dart';
import 'package:happy_habit/core/shared/widgets/app_toast.dart';

import 'constants.dart';

class ApiResponseGeneric {
  int? code;
  bool success;
  String? type;
  dynamic data;
  String? message;
  // Map<String, dynamic>? data;

  ApiResponseGeneric({
    this.code,
    this.data,
    this.type,
    this.message,
    this.success = false,
  });

  factory ApiResponseGeneric.fromResponse(Response response) {
    return ApiResponseGeneric(
      code: response.statusCode,
      message: response.data['message'],
      data: response.data['data'] ?? response.data,
      success: response.statusCode == 200 || response.statusCode == 201,
    );
  }

  void showMessage({bool onSuccess = false}) {
    if ((success && onSuccess) || (!success && !onSuccess)) {
      AppToast.show(
        message!,
        type: success ? AppToastType.success : AppToastType.error,
      );
    }
  }
}

// ignore: constant_identifier_names
enum RequestType { GET, PUT, POST, PATCH }

class RequestMedium {
  static String get currentMedium =>
      Platform.isAndroid ? NetworkConstants.platformAndroid : NetworkConstants.platformIOS;
}
