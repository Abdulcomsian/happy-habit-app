import 'package:happy_habit/core/networking/api_networking_layer.dart';
import 'package:happy_habit/core/networking/networking_models.dart';

class MediaNetworking {
  final _networkingLayer = ApiNetworkingLayer();

  Future<Map<String, String>?> getMusics() async {
    const urlExt = '/api/get-media';

    final ApiResponseGeneric response = await _networkingLayer.makeRequest(
      RequestType.GET,
      urlExt,
      hasToken: true,
    );

    // Check if the response data is valid and contains media items
    if (response.success && response.data != null && response.data?['media'] != null) {
      // Map the list of media into a Map<String, String>
      Map<String, String> mediaMap = {};
      List<dynamic> mediaList = response.data!['media'];

      for (var mediaItem in mediaList) {
        mediaItem.forEach((key, value) {
          mediaMap[key] = value;
        });
      }

      return mediaMap;
    } else {
      return null;
    }
  }
}
