import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:happy_habit/core/services/providers.dart';
import 'package:happy_habit/modules/auth/services/auth_provider.dart';
import 'package:happy_habit/modules/profile_setup/services/character_attributes.dart';
import 'package:rive/rive.dart';

import '../constants/asset_paths.dart';
import '../services/logger.dart';

class AvatarProvider extends ChangeNotifier {
  static final AvatarProvider _instance = AvatarProvider._internal();

  factory AvatarProvider() => _instance;

  AvatarProvider._internal();

  // Your methods and properties here
  late Artboard userArtboard;
  late Artboard maleArtboard, femaleArtboard;

  void initializeUserArtboard({Artboard? artboard}) async {
    if (artboard != null) {
      userArtboard = artboard;
    } else {
      final attributes =
          serviceLocator<AuthProvider>().appUser?.characterAttributes ?? CharacterAttributes();
      await rootBundle.load(attributes.path).then(
        (data) async {
          try {
            final file = RiveFile.import(data);
            userArtboard = file.mainArtboard;

            // var controller = StateMachineController.fromArtboard(artboard, attributes.machineCode);

            // if (controller != null) {
            //   artboard.addController(controller);

            // for (var element in controller.inputs) {
            //   Logger.logInfo("Element: $element, ${element.name}, ${element.runtimeType}");
            //
            //   // adding as per name, without this it wont change the characters element i.e. hairs
            //   _addAttributes(element);
            // }
            // }
            // setState(() => riveArtboard = artboard);
            // riveArtboard = artboard;
            // _isLoading.value = false;
          } catch (e) {
            Logger.logError('initializeUserArtboard()=> $e');
          }
        },
      );
    }
    notifyListeners();
  }

  Future<void> loadCharacters() async {
    await Future.wait([
      _loadMaleCharacter(),
      _loadFemaleCharacter(),
    ]);
  }

  Future<void> _loadMaleCharacter() async {
    await rootBundle.load(AppCharacters.male).then(
      (data) async {
        try {
          final file = RiveFile.import(data);
          maleArtboard = file.mainArtboard;
        } catch (e) {
          Logger.logError('_loadMaleCharacter()=> $e');
        }
      },
    );
  }

  Future<void> _loadFemaleCharacter() async {
    await rootBundle.load(AppCharacters.female).then(
      (data) async {
        try {
          final file = RiveFile.import(data);
          femaleArtboard = file.mainArtboard;
        } catch (e) {
          Logger.logError('_loadFemaleCharacter()=> $e');
        }
      },
    );
  }
}
