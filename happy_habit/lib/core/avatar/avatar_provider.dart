import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:happy_habit/core/avatar/avatar_extensions.dart';
import 'package:happy_habit/core/services/providers.dart';
import 'package:happy_habit/modules/auth/services/auth_provider.dart';
import 'package:happy_habit/modules/profile_setup/services/avatar_attributes.dart';
import 'package:rive/rive.dart';

import '../../modules/profile_setup/services/app_avatar_elements.dart';
import '../constants/asset_paths.dart';
import '../services/logger.dart';
import 'avatar_networking.dart';

class AvatarProvider extends ChangeNotifier {
  static final AvatarProvider _instance = AvatarProvider._internal();

  factory AvatarProvider() => _instance;

  AvatarProvider._internal();

  // Your methods and properties here
  final _networkingLayer = AvatarNetworking();

  ByteData get maleRiv => _maleRiv;
  late ByteData _maleRiv;

  ByteData get femaleRiv => _femaleRiv;
  late ByteData _femaleRiv;

  late Artboard userArtboard;
  late Artboard maleArtboard, femaleArtboard;

  AppAvatarElements get maleElements => _maleElements;
  late AppAvatarElements _maleElements;

  AppAvatarElements get femaleElements => _femaleElements;
  late AppAvatarElements _femaleElements;

  Future<void> getCharacterElements() async {
    ({AppAvatarElements maleElements, AppAvatarElements femaleElements})? elements;

    // Keep trying to fetch accessories until we get a non-null elements
    while (elements == null) {
      elements = await _networkingLayer.getCharacterElements();
      if (elements == null) {
        await Future.delayed(Duration(seconds: 2)); // Add a delay to prevent tight looping
      }
    }

    // Once we have a valid elements, update _accessories
    _maleElements = elements.maleElements;
    _femaleElements = elements.femaleElements;
  }

  void initializeUserArtboard({Artboard? artboard, AvatarAttributes? avatarAttributes}) async {
    final authProv = serviceLocator<AuthProvider>();
    final appUser = authProv.appUser;
    if (artboard != null) {
      userArtboard = artboard;
    } else {
      final attributes = avatarAttributes ?? appUser?.avatarAttributes ?? AvatarAttributes();

      try {
        userArtboard = await attributes.path.loadArtboard();
        var controller = StateMachineController.fromArtboard(userArtboard, attributes.machineCode);

        if (controller != null) {
          userArtboard.addController(controller);

          // Preload user attributes into the artboard
          preloadAttributes(controller, attributes);
        } else {
          Logger.logError('StateMachineController could not be created.');
        }
      } catch (e) {
        Logger.logError('Error loading Rive file: $e');
      }
    }

    notifyListeners();
  }

  Future<void> loadCharacters() async {
    final futures = await Future.wait([
      AppCharacters.male.loadArtboard(),
      AppCharacters.female.loadArtboard(),
    ]);

    maleArtboard = futures.first;
    femaleArtboard = futures.last;

    var mController = StateMachineController.fromArtboard(maleArtboard, AppCharacters.femaleCode);
    var fController = StateMachineController.fromArtboard(femaleArtboard, AppCharacters.femaleCode);

    maleArtboard.addController(mController!);
    femaleArtboard.addController(fController!);
  }

  /// ########################## User Artboard Service ########################## ///

// Helper function to preload attributes
  void preloadAttributes(StateMachineController controller, AvatarAttributes attributes) {
    for (var element in controller.inputs) {
      // Logger.logInfo("Element: ${element.name}, Type: ${element.runtimeType}");
      _addAttributes(element, attributes);
    }
  }

  void _addAttributes(SMIInput<dynamic> element, AvatarAttributes attributes) {
    if (element is SMINumber) {
      double value = 0.0; // Default value

      // Check if attribute exists, and assign the value based on element name
      switch (element.name) {
        case "hair":
          value = attributes.hairNumber.toDouble();
          break;
        case "shoes":
        case "shooes":
          value = attributes.shoesNumber.toDouble();
          break;
        case "hat":
          value = attributes.hatNumber.toDouble();
          break;
        case "eye":
        case "eyes":
          value = attributes.eyeNumber.toDouble();
          break;
        case "eyebrows":
        case "eye brows":
          value = attributes.eyebrowsNumber.toDouble();
          break;
        case "mouth":
          value = attributes.mouthNumber.toDouble();
          break;
        case "body":
        case "cloth":
        case "clothing":
        case "clothing ":
          value = attributes.clothingNumber.toDouble();
          break;
        case "body colore":
          value = attributes.bodyColorNumber.toDouble();
          break;
        case "beard and hat":
          if (attributes.isMale) {
            value = attributes.beardNumber.toDouble();
          }
          break;
        case "nose":
          value = attributes.noseNumber.toDouble();
          break;
        case "acc":
          value = attributes.accNumber.toDouble();
          break;
        default:
          Logger.logInfo('Unknown element name: ${element.name}');
          break;
      }

      element.value = value; // Apply the value
    } else {
      Logger.logInfo('Element is not of type SMINumber: ${element.runtimeType}');
    }
  }
}
