import 'dart:async';

import 'package:dio/dio.dart';
import 'package:happy_habit/core/services/providers.dart';
import 'package:happy_habit/modules/auth/services/auth_provider.dart';

class RefreshTokenInterceptor extends Interceptor {
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    super.onRequest(options, handler);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (_isAuthenticationError(err)) {
      await _handleAuthenticationError(err, handler);
    } else if (_isAuthorizationError(err)) {
      await _signOut();
    } else {
      super.onError(err, handler);
    }
  }

  @override
  Future<void> onResponse(Response response, ResponseInterceptorHandler handler) async {
    super.onResponse(response, handler);
  }

  bool _isAuthenticationError(DioException err) {
    return err.response != null && err.response!.statusCode == 401;
  }

  bool _isAuthorizationError(DioException err) {
    return err.response != null && err.response!.statusCode == 403;
  }

  Future<void> _handleAuthenticationError(DioException err, ErrorInterceptorHandler handler) async {
    if (await serviceLocator<AuthProvider>().refreshToken()) {
      final response = await _retry(err.requestOptions);
      return handler.resolve(response);
    } else {
      await _signOut();
      super.onError(err, handler);
    }
  }

  Future<void> _signOut() async {
    await serviceLocator<AuthProvider>().logout();
  }

  Future<Response> _retry(RequestOptions requestOptions) async {
    String accessToken = serviceLocator<AuthProvider>().authToken!.accessToken;

    final response = await Dio().request(
      requestOptions.path,
      data: requestOptions.data,
      options: Options(
        method: requestOptions.method,
        contentType: Headers.jsonContentType,
        headers: {'Authorization': accessToken},
      ),
    );
    return response;
  }
}
