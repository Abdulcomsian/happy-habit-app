import 'package:happy_habit/core/networking/api_networking_layer.dart';
import 'package:happy_habit/core/networking/networking_models.dart';
import 'package:happy_habit/modules/activity/shared/models/activity.dart';

class ActivityNetworking {
  final _networkingLayer = ApiNetworkingLayer();

  Future<List<Activity>?> getActivities() async {
    const urlExt = '/api/get-user-activities';

    final ApiResponseGeneric response = await _networkingLayer.makeRequest(
      RequestType.GET,
      urlExt,
      hasToken: true,
    );

    return (response.data?['activities'] as List<dynamic>?)?.map((x) => Activity.fromJson(x)).toList();
  }
}
