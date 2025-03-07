import 'package:happy_habit/core/networking/api_networking_layer.dart';
import 'package:happy_habit/core/networking/networking_models.dart';
import 'package:happy_habit/modules/social/shared/models/other_user.dart';

class SocialNetworking {
  final _networkingLayer = ApiNetworkingLayer();

  Future<List<OtherUser>?> getFriends() async {
    const urlExt = '/api/get-friends';

    final ApiResponseGeneric response = await _networkingLayer.makeRequest(
      RequestType.GET,
      urlExt,
      hasToken: true,
    );

    return (response.data?['friends'] as List<dynamic>?)?.map((x) => OtherUser.fromJson(x)).toList();
  }

  Future<List<OtherUser>?> getPendingRequests() async {
    const urlExt = '/api/get-pending-requests';

    final ApiResponseGeneric response = await _networkingLayer.makeRequest(
      RequestType.GET,
      urlExt,
      hasToken: true,
    );

    return (response.data?['Pending_request'] as List<dynamic>?)?.map((x) => OtherUser.fromJson(x)).toList();
  }
}
