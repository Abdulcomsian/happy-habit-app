import 'package:dio/dio.dart';
import 'package:happy_habit/core/networking/api_networking_layer.dart';
import 'package:happy_habit/core/networking/networking_models.dart';
import 'package:happy_habit/modules/auth/services/app_user.dart';
import 'package:happy_habit/modules/auth/services/auth_token.dart';

class AuthNetworking {
  final _networkingLayer = ApiNetworkingLayer();

  Future<int?> signup(Map<String, dynamic> body) async {
    const urlExt = '/api/register';

    final response = await _networkingLayer.makeRequest(
      RequestType.POST,
      urlExt,
      body: FormData.fromMap(body),
    );

    response.showMessage();
    if (response.success && response.data != null) {
      return response.data!['user_id'];
    } else {
      return null;
    }
  }

  Future<({AuthToken authToken, AppUser appUser})?> login(String email, String password) async {
    const urlExt = '/api/login';

    final response = await _networkingLayer.makeRequest(
      RequestType.POST,
      urlExt,
      body: FormData.fromMap({
        'email': email,
        'password': password,
      }),
    );

    response.showMessage();
    if (response.success && response.data != null) {
      final authToken = AuthToken.fromJson(response.data!);
      final appUser = AppUser.fromJson(response.data!['user']);
      return (authToken: authToken, appUser: appUser);
    }
    return null;
  }

  Future<AppUser?> getUserProfile() async {
    const urlExt = '/api/my-profile';

    final response = await _networkingLayer.makeRequest(
      RequestType.GET,
      urlExt,
      hasToken: true,
    );

    response.showMessage();
    if (response.success && response.data != null) {
      return AppUser.fromJson(response.data!);
    }
    return null;
  }

  Future<bool> sendOtp(int uid) async {
    const urlExt = '/api/resend-otp';

    final response = await _networkingLayer.makeRequest(
      RequestType.POST,
      urlExt,
      body: FormData.fromMap({
        'user_id': uid,
      }),
    );

    response.showMessage();
    return response.success;
  }

  Future<bool> verifyOtp(int uid, int otp) async {
    const urlExt = '/api/verify-otp';

    final response = await _networkingLayer.makeRequest(
      RequestType.POST,
      urlExt,
      body: FormData.fromMap({
        'otp': otp,
        'user_id': uid,
      }),
    );

    response.showMessage();
    return response.success;
  }

  Future<int?> forgotPassword(String email) async {
    const urlExt = '/api/send-email-forgot-password';

    final response = await _networkingLayer.makeRequest(
      RequestType.POST,
      urlExt,
      body: FormData.fromMap({
        'email': email,
      }),
    );

    if (response.success && response.data != null) {
      return response.data!['user_id'];
    } else {
      return null;
    }
  }

  Future<bool> updatePassword(int uid, String password) async {
    const urlExt = '/api/update-password';

    final response = await _networkingLayer.makeRequest(
      RequestType.POST,
      urlExt,
      body: FormData.fromMap({
        'user_id': uid,
        'password': password,
      }),
    );

    response.showMessage();
    return response.success;
  }

  Future<AuthToken?> refreshToken(String token) async {
    const urlExt = '/api/refresh-token';

    final response = await _networkingLayer.makeRequest(
      RequestType.POST,
      urlExt,
      body: FormData.fromMap({
        'token': token,
      }),
    );

    if (response.success && response.data != null) {
      final token = {
        'access_token': response.data!['refresh_token'],
      };
      return AuthToken.fromJson(token);
    } else {
      return null;
    }
  }
}
