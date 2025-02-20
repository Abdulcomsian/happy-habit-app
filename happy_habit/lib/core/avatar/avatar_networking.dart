import 'package:happy_habit/core/networking/api_networking_layer.dart';

import '../../modules/profile_setup/services/character_accessories.dart';
import '../networking/networking_models.dart';

class AvatarNetworking {
  final _networkingLayer = ApiNetworkingLayer();
  Future<CharacterAccessories?> getCharacterAccessories() async {
    const urlExt = '/api/get-accessories';

    final response = await _networkingLayer.makeRequest(
      RequestType.GET,
      urlExt,
      hasToken: true,
    );

    if (response.success && response.data != null) {
      return CharacterAccessories.fromJson(response.data!);
    }
    return null;
  }
}