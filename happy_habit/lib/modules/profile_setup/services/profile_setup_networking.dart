import 'package:dio/dio.dart';
import 'package:happy_habit/core/networking/api_networking_layer.dart';

import '../../../core/networking/networking_models.dart';
import 'goal.dart';

class ProfileSetupNetworking {
  final _networkingLayer = ApiNetworkingLayer();

  Future<bool> validateUsername(String username) async {
    const urlExt = '/api/check-username';

    final response = await _networkingLayer.makeRequest(
      RequestType.POST,
      urlExt,
      hasToken: true,
      body: FormData.fromMap(
        {'username': username},
      ),
    );

    return response.success;
  }

  Future<bool> setUsername(int uid, String username) async {
    const urlExt = '/api/set-username';

    final response = await _networkingLayer.makeRequest(
      RequestType.POST,
      urlExt,
      hasToken: true,
      body: FormData.fromMap({
        'user_id': uid,
        'username': username,
      }),
    );

    response.showMessage();
    return response.success;
  }

  Future<List<Goal>?> getGoals() async {
    const urlExt = '/api/get-goals';

    final response = await _networkingLayer.makeRequest(
      RequestType.GET,
      urlExt,
      hasToken: true,
    );

    response.showMessage();
    final goals =
        (response.data?['goals'] as List<dynamic>?)?.map((x) => Goal.fromJson(x)).toList();
    return goals;
  }

  Future<bool> setGoals(Map<String, dynamic> body) async {
    const urlExt = '/api/set-goals';

    final response = await _networkingLayer.makeRequest(
      RequestType.POST,
      urlExt,
      hasToken: true,
      body: {'goals': body},
    );

    response.showMessage();
    return response.success;
  }

  Future<bool> setAvatar(Map<String, dynamic> body) async {
    const urlExt = '/api/set-avatar';
    final response = await _networkingLayer.makeRequest(
      RequestType.POST,
      urlExt,
      hasToken: true,
      body: FormData.fromMap(body),
    );

    response.showMessage();
    return response.success;
  }
}
