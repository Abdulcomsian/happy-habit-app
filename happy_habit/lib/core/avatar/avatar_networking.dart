import 'package:happy_habit/core/networking/api_networking_layer.dart';

import '../../modules/profile_setup/services/app_avatar_elements.dart';
import '../networking/networking_models.dart';

class AvatarNetworking {
  final _networkingLayer = ApiNetworkingLayer();

  Future<({AppAvatarElements maleElements, AppAvatarElements femaleElements})?>
      getCharacterElements() async {
    const urlExt = '/api/get-accessories';

    final response = await _networkingLayer.makeRequest(
      RequestType.GET,
      urlExt,
      hasToken: true,
    );

    if (response.success && response.data != null) {
      final maleElements = AppAvatarElements.fromJson(response.data!['male']);
      final femaleElements = AppAvatarElements.fromJson(response.data!['female']);
      return (maleElements: maleElements, femaleElements: femaleElements);
    }
    return null;
  }
}
