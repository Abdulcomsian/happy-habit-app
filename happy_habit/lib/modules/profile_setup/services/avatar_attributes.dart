import '../../../core/constants/asset_paths.dart';

class AvatarAttributes {
  int hairNumber;
  int shoesNumber;
  int hatNumber;
  int eyeNumber;
  int eyebrowsNumber;
  int mouthNumber;
  int clothingNumber;
  int bodyColorNumber;
  int beardNumber;
  int noseNumber;
  int accNumber;
  int animationNumber;
  bool isMale;

  // History stack to keep track of previous states
  // List<CharacterAttributes> history = [];

  // AvatarAttributes({
  //   this.hairNumber = 0,
  //   this.shoesNumber = 0,
  //   this.hatNumber = 0,
  //   this.eyeNumber = 0,
  //   this.eyebrowsNumber = 0,
  //   this.mouthNumber = 0,
  //   this.clothingNumber = 0,
  //   this.bodyColorNumber = 0,
  //   this.beardNumber = 0,
  //   this.noseNumber = 0,
  //   this.accNumber = 0,
  //   this.animationNumber = 0,
  //   this.isMale = true,
  // });

  /// for testing
  AvatarAttributes({
    this.hairNumber = 6 ?? 0,
    this.shoesNumber = 0,
    this.hatNumber = 0,
    this.eyeNumber = 0,
    this.eyebrowsNumber = 43 ?? 0,
    this.mouthNumber = 3 ?? 0,
    this.clothingNumber = 5 ?? 0,
    this.bodyColorNumber = 17 ?? 0,
    this.beardNumber = 1 ?? 0,
    this.noseNumber = 0,
    this.accNumber = 0,
    this.animationNumber = 0,
    this.isMale = true,
  });

  factory AvatarAttributes.fromJson(Map<String, dynamic> json) {
    return AvatarAttributes(
      eyeNumber: json['eyes_id'] ?? 0,
      hairNumber: json['hair_id'] ?? 0,
      noseNumber: json['noses_id'] ?? 0,
      mouthNumber: json['lips_id'] ?? 0,
      beardNumber: json['beards_id'] ?? 0,
      bodyColorNumber: json['color_id'] ?? 0,
      eyebrowsNumber: json['eyebrows_id'] ?? 0,
      isMale: bool.tryParse(json['is_male']) ?? true,

      /// needs to update
      hatNumber: json['hatNumber'] ?? 0,
      accNumber: json['accNumber'] ?? 0,
      shoesNumber: json['shoesNumber'] ?? 0,
      clothingNumber: json['clothingNumber'] ?? 0,
    );
  }

  // Factory constructor to create a new AvatarAttributes instance by copying another
  factory AvatarAttributes.copyFrom(AvatarAttributes other) {
    return AvatarAttributes(
      hairNumber: other.hairNumber,
      shoesNumber: other.shoesNumber,
      hatNumber: other.hatNumber,
      eyeNumber: other.eyeNumber,
      eyebrowsNumber: other.eyebrowsNumber,
      mouthNumber: other.mouthNumber,
      clothingNumber: other.clothingNumber,
      bodyColorNumber: other.bodyColorNumber,
      beardNumber: other.beardNumber,
      noseNumber: other.noseNumber,
      accNumber: other.accNumber,
      animationNumber: other.animationNumber,
      isMale: other.isMale,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'is_male': isMale,
      "hair_id": hairNumber,
      "eyes_id": eyeNumber,
      "eyebrows_id": eyebrowsNumber,
      "noses_id": noseNumber,
      "lips_id": mouthNumber,
      "accessories_id": accNumber,
      "faceshap_id": bodyColorNumber,
      "cloth_id": clothingNumber,
      "shoe_id": shoesNumber,
      "hat_id": hatNumber,
      "beards_id": beardNumber
    };
  }

  String get machineCode => isMale ? AppCharacters.maleCode : AppCharacters.femaleCode;

  String get path => isMale ? 'assets/characters/male.riv' : 'assets/characters/female.riv';

  String activityPath(String activity) {
    activity = activity.toLowerCase();
    final gender = isMale ? 'male' : 'female';
    switch (activity) {
      case 'workout':
        return 'assets/transitions/$gender-workout.riv';
      case 'meditation':
        return 'assets/transitions/$gender-meditation.riv';
      default:
        return 'assets/transitions/$gender-reading.riv';
    }
  }

  String activityMachineCode(String activity) {
    activity = activity.toLowerCase();
    switch (activity) {
      case 'read':
      case 'study':
        return isMale ? 'boy lofi' : 'female lofi and reading';
      case 'meditation':
        return isMale ? 'male meditation' : 'meditation';
      default:
        return isMale ? 'boy exercise' : 'female rest of the animation';
    }
  }

// Named constructor to initialize all values to 0
// CharacterAttributes.allZero(bool? male) :
//       hairNumber = 0,
//       shoesNumber = 0,
//       hatNumber = 0,
//       eyeNumber = 0,
//       eyebrowsNumber = 0,
//       mouthNumber = 0,
//       clothingNumber = 0,
//       bodyColorNumber = 0,
//       beardNumber = 0,
//       noseNumber = 0,
//       accNumber = 0,
//       animationNumber = 0,
//       isMale = male ?? true;

// Save the current state to the history stack
// void saveState() {
//   history.add(CharacterAttributes(
//     hairNumber: hairNumber,
//     shoesNumber: shoesNumber,
//     hatNumber: hatNumber,
//     eyeNumber: eyeNumber,
//     eyebrowsNumber: eyebrowsNumber,
//     mouthNumber: mouthNumber,
//     clothingNumber: clothingNumber,
//     bodyColorNumber: bodyColorNumber,
//     beardNumber: beardNumber,
//     noseNumber: noseNumber,
//     accNumber: accNumber,
//     animationNumber: animationNumber,
//     isMale: isMale,
//   ));
// }

// Undo the last change
// void undo() {
//   if (history.isNotEmpty) {
//     final previousState = history.removeLast();
//     hairNumber = previousState.hairNumber;
//     shoesNumber = previousState.shoesNumber;
//     hatNumber = previousState.hatNumber;
//     eyeNumber = previousState.eyeNumber;
//     eyebrowsNumber = previousState.eyebrowsNumber;
//     mouthNumber = previousState.mouthNumber;
//     clothingNumber = previousState.clothingNumber;
//     bodyColorNumber = previousState.bodyColorNumber;
//     beardNumber = previousState.beardNumber;
//     noseNumber = previousState.noseNumber;
//     accNumber = previousState.accNumber;
//     animationNumber = previousState.animationNumber;
//     isMale = previousState.isMale;
//   }
// }
}
