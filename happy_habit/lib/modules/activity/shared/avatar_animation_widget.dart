import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:happy_habit/core/avatar/avatar_extensions.dart';
import 'package:rive/rive.dart';

import '../../../core/services/logger.dart';
import '../../../core/services/providers.dart';
import '../../../core/shared/widgets/circular_bounce_loader.dart';
import '../../auth/services/auth_provider.dart';
import '../../profile_setup/services/avatar_attributes.dart';

class AvatarAnimationWidget extends StatefulWidget {
  final int minute;
  final String activity;

  const AvatarAnimationWidget({
    super.key,
    required this.minute,
    required this.activity,
  });

  @override
  State<AvatarAnimationWidget> createState() => _AvatarAnimationWidgetState();
}

class _AvatarAnimationWidgetState extends State<AvatarAnimationWidget> {
  final _authProv = serviceLocator<AuthProvider>();

  late Artboard riveArtboard;
  late AvatarAttributes attributes;

  final _isLoading = ValueNotifier(true);

  @override
  void initState() {
    super.initState();
    attributes = AvatarAttributes.copyFrom(_authProv.appUser!.avatarAttributes!);
    _loadCharacter();
    if (widget.activity.toLowerCase() == 'workout') _startSwitching();
  }

  void _loadCharacter() async {
    try {
      final artboard = await attributes.activityPath(widget.activity).loadArtboard();

      final machineCode = attributes.activityMachineCode(widget.activity);
      var controller = StateMachineController.fromArtboard(artboard, machineCode);

      if (controller != null) {
        artboard.addController(controller);

        for (var element in controller.inputs) {
          // Logger.logInfo("Element: $element, ${element.name}, ${element.runtimeType}");

          // adding as per name, without this it wont change the characters element i.e. hairs
          _addAttributes(element);
          _setPreValues();
        }
      }
      // setState(() => riveArtboard = artboard);
      riveArtboard = artboard;
    } catch (e) {
      Logger.logError(e);
    } finally {
      _isLoading.value = false;
    }
  }

  double _getAnimationValue() {
    switch (widget.activity) {
      case "study":
      case "Study":
        return 0;
      case "read":
      case "Read":
        return 1;
      case "pushup":
      case "Pushup":
        return 2;
      case "situps":
      case "Situps":
        return 1;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _isLoading,
      builder: (context, loading, _) {
        if (loading) {
          return Center(
            child: CircleBounceLoader(),
          );
        }

        return Container(
          color: Colors.white,
          child: Rive(
            fit: BoxFit.fitHeight,
            artboard: riveArtboard,
          ),
        );
      },
    );
  }

  SMINumber? num;
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
  SMINumber? animationSMINumber; // todo: no use

  void _addAttributes(SMIInput<dynamic> element) {
    if (element is SMINumber) {
      // Check if attribute exists, and assign the value based on element name
      switch (element.name) {
        case "hair":
          hairNumber = element;
          break;
        case "shoes":
        case "shooes":
          shoesNumber = element;
          break;
        case "hat":
          hatNumber = element;
          break;
        case "eye":
        case "eyes":
          eyeNumber = element;
          break;
        case "eyebrows":
        case "eye brows":
          eyebrowsNumber = element;
          break;
        case "mouth":
          mouthNumber = element;
          break;
        case "body":
        case "cloth":
        case "clothing":
        case "clothing ":
          clothingNumber = element;
          break;
        case "body colore":
          colorNumber = element;
          break;
        case "beard and hat":
          if (attributes.isMale) {
            beardNumber = element;
          }
          break;
        case "nose":
          noseNumber = element;
          break;
        case "acc":
          accNumber = element;
        case "animation":
        case "aniamtion":
          animationSMINumber = element;
          break;
        default:
          Logger.logInfo('Unknown element name: ${element.name}');
          break;
      }
    }
  }

  void _setPreValues() {
    hairNumber?.change(attributes.hairNumber.toDouble());
    shoesNumber?.change(attributes.shoesNumber.toDouble());
    eyeNumber?.change(attributes.eyeNumber.toDouble());
    eyebrowsNumber?.change(attributes.eyebrowsNumber.toDouble());
    hatNumber?.change(attributes.hatNumber.toDouble());
    mouthNumber?.change(attributes.mouthNumber.toDouble());
    clothingNumber?.change(attributes.clothingNumber.toDouble());
    colorNumber?.change(attributes.bodyColorNumber.toDouble());
    beardNumber?.change(attributes.beardNumber.toDouble());
    noseNumber?.change(attributes.noseNumber.toDouble());
    accNumber?.change(attributes.accNumber.toDouble());
    animationSMINumber?.change(_getAnimationValue());
  }

  Timer? _timer;
  List<int> _displayedNumbers = [];

  void _startSwitching() {
    _stopTimer();
    if (widget.minute < 2) {
      _switchAtEqualIntervals();
    } else {
      _switchAtRandomIntervals();
    }
  }

  void _switchAtRandomIntervals() {
    _timer = Timer(Duration(minutes: 3), () {
      _switchNumber();
      _switchAtRandomIntervals();
    });
  }

  void _switchAtEqualIntervals() {
    int interval =
        (widget.minute * 60) ~/ 4; // Convert total time to seconds and divide by 5 intervals
    _timer = Timer.periodic(Duration(seconds: interval), (timer) {
      _switchNumber();

      if (_displayedNumbers.length >= 4) {
        timer.cancel();
      }
    });
  }

  _switchNumber() {
    int newNumber;
    do {
      newNumber = Random().nextInt(4);
    } while (_displayedNumbers.contains(newNumber));

    animationSMINumber?.change(newNumber.toDouble());

    _displayedNumbers.add(newNumber);
  }

  void _stopTimer() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
  }
}
