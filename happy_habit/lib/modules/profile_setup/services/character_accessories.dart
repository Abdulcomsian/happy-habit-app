class CharacterAccessories {
  List<Accessory> colors;
  List<Accessory> hairs;
  List<Accessory> shirts;
  List<Accessory> glasses;
  List<Accessory> eyes;
  List<Accessory> eyeBrows;
  List<Accessory> noses;
  List<Accessory> lips;
  List<Accessory> beards;

  CharacterAccessories({
    required this.colors,
    required this.hairs,
    required this.shirts,
    required this.glasses,
    required this.eyes,
    required this.eyeBrows,
    required this.noses,
    required this.lips,
    required this.beards,
  });

  factory CharacterAccessories.fromJson(Map<String, dynamic> json, {String? key}) {
    return CharacterAccessories(
      hairs: (json['hairs'] as List<dynamic>?)?.map((x) => Accessory.fromJson(x)).toList() ?? [],
      shirts: (json['shirts'] as List<dynamic>?)?.map((x) => Accessory.fromJson(x)).toList() ?? [],
      glasses:
          (json['glasses'] as List<dynamic>?)?.map((x) => Accessory.fromJson(x)).toList() ?? [],
      eyes: (json['eyes'] as List<dynamic>?)?.map((x) => Accessory.fromJson(x)).toList() ?? [],
      eyeBrows:
          (json['eyeBrows'] as List<dynamic>?)?.map((x) => Accessory.fromJson(x)).toList() ?? [],
      noses: (json['noses'] as List<dynamic>?)?.map((x) => Accessory.fromJson(x)).toList() ?? [],
      lips: (json['lips'] as List<dynamic>?)?.map((x) => Accessory.fromJson(x)).toList() ?? [],
      beards: (json['beards'] as List<dynamic>?)?.map((x) => Accessory.fromJson(x)).toList() ?? [],
      colors: (json['colors'] as List<dynamic>?)
              ?.map((x) => Accessory.fromJson(x, key: 'code'))
              .toList() ??
          [],
    );
  }
}

class Accessory {
  final int id;
  final String value;

  const Accessory({
    required this.id,
    required this.value,
  });

  factory Accessory.fromJson(Map<String, dynamic> json, {String? key}) {
    return Accessory(
      id: json['id'],
      value: json[key ?? 'image'],
    );
  }
}
