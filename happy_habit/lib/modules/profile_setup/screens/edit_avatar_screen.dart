import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:happy_habit/core/constants/avatar_asset_paths.dart';
import 'package:happy_habit/core/extensions/string_extensions.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/services/logger.dart';
import 'package:happy_habit/core/theme/theme_colors.dart';
import 'package:happy_habit/modules/profile_setup/shared/elements_list.dart';
import 'package:happy_habit/modules/profile_setup/shared/element_types_list.dart';
import 'package:rive/rive.dart';

import '../services/character_attributes.dart';
import '../shared/avatar_section.dart';

class EditAvatarScreen extends StatefulWidget {
  static const id = 'EditAvatarScreen';

  final String characterPath;

  const EditAvatarScreen({super.key, required this.characterPath});

  @override
  State<EditAvatarScreen> createState() => _EditAvatarScreenState();
}

class _EditAvatarScreenState extends State<EditAvatarScreen> {
  String _avatar = '';
  String character = '';
  Artboard? riveArtboard;
  String characterPath = 'assets/characters/male.riv';
  CharacterAttributes attributes = CharacterAttributes();

  final _selectedElementTypes = ValueNotifier(AvatarIcons.elements.first);
  final _elementType = ValueNotifier(AvatarIcons.elements.first.basenameWithoutExtension());

  @override
  void initState() {
    super.initState();
    _avatar = widget.characterPath.basenameWithoutExtension();
    _loadCharacter();
  }

  _loadCharacter() {
    // rootBundle.load(widget.avatar).then(
    rootBundle.load(characterPath).then(
          (data) async {
        try {
          final file = RiveFile.import(data);
          final artboard = file.mainArtboard;

          var machineCode = characterPath.contains("male") ? 'State Machine 2' : 'State Machine 1';

          character = characterPath.contains("male") ? "male" : "female";

          Logger.logInfo("Character: $character");

          var controller = StateMachineController.fromArtboard(artboard, machineCode);

          if (controller != null) {
            artboard.addController(controller);

            for (var element in controller.inputs) {
              Logger.logInfo("Element: $element, ${element.name}, ${element.runtimeType}");

              // adding as per name, without this it wont change the characters element i.e. hairs
              _addAttributes(element);
            }
          }
          setState(() => riveArtboard = artboard);
        } catch (e) {
          Logger.logError(e);
        }
      },
    );
  }


  void _setAccessory(String path) {
    _selectedElementTypes.value = path;
    _elementType.value = path.basenameWithoutExtension();
  }

  @override
  void dispose() {
    _elementType.dispose();
    _selectedElement.dispose();
    _selectedElementTypes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.background,
      body: Column(
        children: [
          AvatarSection(
            artboard: riveArtboard,
            avatar: widget.characterPath,
          ),
          13.height,
          Align(
            alignment: Alignment.centerRight,
            child: ElementTypesList(
              onChanged: _setAccessory,
              isFemale: widget.characterPath.contains('female'),
              selectedAccessoriesTypes: _selectedElementTypes,
            ),
          ),
          13.height,
          ElementsList(
            avatar: _avatar,
            onChanged: _setValue,
            elementType: _elementType,
            selectedElement: _selectedElement,
          ),
        ],
      ),
    );
  }

  final ValueNotifier<Map<String, String>> _selectedElement = ValueNotifier({});

  _setValue(int number, String element, {bool isNotify = true}) {
    // Logger.logInfo('apply $number on $element');
    switch (element) {
      case 'hairs':
        _setHair(number);
        break;
      case 'beard':
        _setBeard(number);
        break;
      case 'eye':
        _setEye(number);
        break;
      case 'eyebrows':
        _setEyebrows(number);
        break;
      case 'face':
        _setColor(number);
        break;
      case 'mouth':
        _setMouth(number);
        break;
      case 'nose':
        _setNose(number);
        break;
      case 'top':
        _setCloth(number);
        break;
      case 'hat':
        _setHat(number);
        break;
    }

    if (isNotify) setState(() {});
  }

  SMINumber? noseNumber;
  SMINumber? beardNumber;
  SMINumber? colorNumber;
  SMINumber? shoesNumber;
  SMINumber? clothingNumber;
  SMINumber? mouthNumber;
  SMINumber? eyeNumber;
  SMINumber? eyebrowsNumber;
  SMINumber? hairNumber;
  SMINumber? hatNumber;
  SMINumber? accNumber; // todo: no use
  SMINumber? currentSMINumber; // todo: no use
  // SMINumber? animationSMINumber; // todo: no use

  _setNose(int number) {
    if (attributes.noseNumber != number) {
      attributes.noseNumber = number; // Update the attribute
      noseNumber?.change(attributes.noseNumber.toDouble()); // Now update the Rive input
    }
  }
  _setBeard(int number) {
    if (attributes.beardNumber != number) {
      attributes.beardNumber = number;
      beardNumber?.change(attributes.beardNumber.toDouble());
    }
  }
  _setColor(int number) {
    if (attributes.bodyColorNumber != number) {
      attributes.bodyColorNumber = number;
      colorNumber?.change(attributes.bodyColorNumber.toDouble());
    }
  }
  _setShoes(int number) {
    if (attributes.shoesNumber != number) {
      attributes.shoesNumber = number;
      shoesNumber?.change(attributes.shoesNumber.toDouble());
    }
  }
  _setCloth(int number) {
    if (attributes.clothingNumber != number) {
      attributes.clothingNumber = number;
      clothingNumber?.change(attributes.clothingNumber.toDouble());
    }
  }
  _setMouth(int number) {
    if (attributes.mouthNumber != number) {
      attributes.mouthNumber = number;
      mouthNumber?.change(attributes.mouthNumber.toDouble());
    }
  }
  _setEye(int number) {
    if (attributes.eyeNumber != number) {
      attributes.eyeNumber = number;
      eyeNumber?.change(attributes.eyeNumber.toDouble());
    }
  }
  _setEyebrows(int number) {
    if (attributes.eyebrowsNumber != number) {
      attributes.eyebrowsNumber = number;
      eyebrowsNumber?.change(attributes.eyebrowsNumber.toDouble());
    }
  }
  _setHat(int number) {
    if (attributes.hatNumber != number) {
      attributes.hatNumber = number;
      hatNumber?.change(attributes.hatNumber.toDouble());
    }
  }

  _setHair(int number) {
    if (attributes.hairNumber != number) {
      attributes.hairNumber = number;
      hairNumber?.change(attributes.hairNumber.toDouble());
    }
  }

  _setAcc(int number) {
    if (attributes.accNumber != number) {
      attributes.accNumber = number;
      accNumber?.change(attributes.accNumber.toDouble());
    }
  }

  // _setAnimation(int number) {
  //   if (attributes.accNumber != number) {
  //     attributes.accNumber = number;
  //     accNumber?.change(attributes.accNumber.toDouble());
  //   }
  // }

  void _addAttributes(SMIInput<dynamic> element){
    if (element.name == "hair") {
      hairNumber = element as SMINumber;
    } else if (element.name == "shoes") {
      shoesNumber = element as SMINumber;
    } else if (element.name == "hat") {
      hatNumber = element as SMINumber;
    } else if (element.name == "eye"/* || element.name == "eyes"*/) {
      eyeNumber = element as SMINumber;
    } else if (element.name == "eye brows" || element.name == "eyebrows") {
      eyebrowsNumber = element as SMINumber;
    } else if (element.name == "mouth") {
      mouthNumber = element as SMINumber;
    } else if (element.name == "clothing" ||
        element.name == "cloth" ||
        element.name == "body") {
      clothingNumber = element as SMINumber;
    } else if (element.name == "body colore") {
      colorNumber = element as SMINumber;
    } else if (element.name == "beard and hat") {
      beardNumber = element as SMINumber;
    } else if (element.name == "nose") {
      noseNumber = element as SMINumber;
    } else if (element.name == "acc") {
      accNumber = element as SMINumber;
    }

    // if (element.name == "aniamtion") {
    //   animationSMINumber = element as SMINumber;
    // }
  }
}
