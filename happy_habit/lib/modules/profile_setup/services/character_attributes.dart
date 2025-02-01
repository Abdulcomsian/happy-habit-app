class CharacterAttributes {
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
  bool male;

  // History stack to keep track of previous states
  List<CharacterAttributes> history = [];

  CharacterAttributes({
    this.hairNumber = 0,
    this.shoesNumber = 0,
    this.hatNumber = 0,
    this.eyeNumber = 0,
    this.eyebrowsNumber = 0,
    this.mouthNumber = 0,
    this.clothingNumber = 0,
    this.bodyColorNumber = 0,
    this.beardNumber = 0,
    this.noseNumber = 0,
    this.accNumber = 0,
    this.animationNumber = 0,
    this.male = true
  });

  // Named constructor to initialize all values to 0
  CharacterAttributes.allZero(bool? male) :
        hairNumber = 0,
        shoesNumber = 0,
        hatNumber = 0,
        eyeNumber = 0,
        eyebrowsNumber = 0,
        mouthNumber = 0,
        clothingNumber = 0,
        bodyColorNumber = 0,
        beardNumber = 0,
        noseNumber = 0,
        accNumber = 0,
        animationNumber = 0,
        male = male ?? true;

  factory CharacterAttributes.fromJson(Map<String, dynamic> json) {
    return CharacterAttributes(
      hairNumber: json['hairNumber'] ?? 0,
      shoesNumber: json['shoesNumber'] ?? 0,
      hatNumber: json['hatNumber'] ?? 0,
      eyeNumber: json['eyeNumber'] ?? 0,
      eyebrowsNumber: json['eyebrowsNumber'] ?? 0,
      mouthNumber: json['mouthNumber'] ?? 0,
      clothingNumber: json['clothingNumber'] ?? 0,
      bodyColorNumber: json['bodyColorNumber'] ?? 0,
      beardNumber: json['beardAndHatNumber'] ?? 0,
      noseNumber: json['noseNumber'] ?? 0,
      accNumber: json['accNumber'] ?? 0,
      male: json['male'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hairNumber': hairNumber,
      'shoesNumber': shoesNumber,
      'hatNumber': hatNumber,
      'eyeNumber': eyeNumber,
      'eyebrowsNumber': eyebrowsNumber,
      'mouthNumber': mouthNumber,
      'clothingNumber': clothingNumber,
      'bodyColorNumber': bodyColorNumber,
      'beardAndHatNumber': beardNumber,
      'noseNumber': noseNumber,
      'accNumber': accNumber,
      'male': male,
    };
  }

  // Save the current state to the history stack
  void saveState() {
    history.add(CharacterAttributes(
      hairNumber: hairNumber,
      shoesNumber: shoesNumber,
      hatNumber: hatNumber,
      eyeNumber: eyeNumber,
      eyebrowsNumber: eyebrowsNumber,
      mouthNumber: mouthNumber,
      clothingNumber: clothingNumber,
      bodyColorNumber: bodyColorNumber,
      beardNumber: beardNumber,
      noseNumber: noseNumber,
      accNumber: accNumber,
      animationNumber: animationNumber,
      male: male,
    ));
  }

  // Undo the last change
  void undo() {
    if (history.isNotEmpty) {
      final previousState = history.removeLast();
      hairNumber = previousState.hairNumber;
      shoesNumber = previousState.shoesNumber;
      hatNumber = previousState.hatNumber;
      eyeNumber = previousState.eyeNumber;
      eyebrowsNumber = previousState.eyebrowsNumber;
      mouthNumber = previousState.mouthNumber;
      clothingNumber = previousState.clothingNumber;
      bodyColorNumber = previousState.bodyColorNumber;
      beardNumber = previousState.beardNumber;
      noseNumber = previousState.noseNumber;
      accNumber = previousState.accNumber;
      animationNumber = previousState.animationNumber;
      male = previousState.male;
    }
  }
}