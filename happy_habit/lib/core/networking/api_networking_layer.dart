import 'package:dio/dio.dart';
import 'package:happy_habit/core/services/logger.dart';

import '../../modules/auth/services/auth_provider.dart';
import '../environment/environment_config.dart';
import '../services/providers.dart';
import '../shared/helper_functions/helper_functions.dart';
import 'error_handler_service.dart';
import 'interceptor/refresh_token_interceptor.dart';
import 'networking_models.dart';

class ApiNetworkingLayer {
  late Dio _dio;
  late Duration _timeoutDuration;

  ApiNetworkingLayer() {
    _dio = Dio();
    _timeoutDuration = Duration(seconds: 10);
    _dio.interceptors.add(RefreshTokenInterceptor());
  }

  Future<ApiResponseGeneric> makeRequest<T>(
    RequestType type,
    String urlExt, {
    dynamic body,
    bool hasToken = false,
  }) async {
    bool hasInternetConnection = await HelperFunctions.hasInternetConnection(showToast: false);
    if (!hasInternetConnection) {
      return ApiResponseGeneric(
        code: 503,
        success: false,
        message: 'Looks like you’re offline. Please check your internet connection and try again',
      );
    }

    final Options options = _generateOptions(
      type.name,
      hasToken,
    );
    return await _dioRequest<T>(
      urlExt,
      options,
      body: body,
    );
  }

  Future<ApiResponseGeneric> _dioRequest<T>(
    String urlExt,
    Options options, {
    dynamic body,
  }) async {
    String url = Environment.baseUrl + urlExt;

    try {
      Response response = await _dio
          .request<T>(
            url,
            data: body,
            options: options,
          )
          .timeout(_timeoutDuration);

      return ApiResponseGeneric.fromResponse(response);
    } catch (e) {
      return CustomExceptionHandler.handleException(e, label: urlExt);
    }
  }

  Options _generateOptions(String method, bool hasToken) {
    Map<String, String> headers = {};

    if (hasToken) {
      String token = serviceLocator<AuthProvider>().authToken!.accessToken;
      headers['Authorization'] = token;
    }

    final Options options = Options(
      method: method,
      headers: headers,
      contentType: Headers.jsonContentType,
    );

    return options;
  }
}

Future<T> testRequest<T>(T object) async {
  await Future.delayed(const Duration(seconds: 2));
  return object;
}
