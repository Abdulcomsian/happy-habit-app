class AppAvatarElements {
  List<AvatarElements> colors;
  List<AvatarElements> hairs;
  List<AvatarElements> shirts;
  List<AvatarElements> glasses;
  List<AvatarElements> eyes;
  List<AvatarElements> eyebrows;
  List<AvatarElements> noses;
  List<AvatarElements> mouth;
  List<AvatarElements> shoes;
  List<AvatarElements> hats;
  List<AvatarElements> beards;
  List<AvatarElements> clothes;
  List<AvatarElements> faceShape;
  List<AvatarElements> accessories;

  AppAvatarElements({
    required this.colors,
    required this.hairs,
    required this.shirts,
    required this.glasses,
    required this.eyes,
    required this.hats,
    required this.eyebrows,
    required this.noses,
    required this.mouth,
    required this.shoes,
    required this.beards,
    required this.clothes,
    required this.faceShape,
    required this.accessories,
  });

  factory AppAvatarElements.fromJson(Map<String, dynamic> json, {String? key}) {
    return AppAvatarElements(
      hairs:
          (json['hairs'] as List<dynamic>?)?.map((x) => AvatarElements.fromJson(x)).toList() ?? [],
      shirts:
          (json['shirts'] as List<dynamic>?)?.map((x) => AvatarElements.fromJson(x)).toList() ?? [],
      glasses:
          (json['glasses'] as List<dynamic>?)?.map((x) => AvatarElements.fromJson(x)).toList() ??
              [],
      eyes: (json['eyes'] as List<dynamic>?)?.map((x) => AvatarElements.fromJson(x)).toList() ?? [],
      eyebrows:
          (json['eyebrows'] as List<dynamic>?)?.map((x) => AvatarElements.fromJson(x)).toList() ??
              [],
      noses:
          (json['noses'] as List<dynamic>?)?.map((x) => AvatarElements.fromJson(x)).toList() ?? [],
      hats: (json['hats'] as List<dynamic>?)?.map((x) => AvatarElements.fromJson(x)).toList() ?? [],
      shoes:
          (json['shoes'] as List<dynamic>?)?.map((x) => AvatarElements.fromJson(x)).toList() ?? [],
      mouth:
          (json['lips'] as List<dynamic>?)?.map((x) => AvatarElements.fromJson(x)).toList() ?? [],
      beards:
          (json['beard'] as List<dynamic>?)?.map((x) => AvatarElements.fromJson(x)).toList() ?? [],
      clothes:
          (json['clothes'] as List<dynamic>?)?.map((x) => AvatarElements.fromJson(x)).toList() ??
              [],
      faceShape:
          (json['faceShape'] as List<dynamic>?)?.map((x) => AvatarElements.fromJson(x)).toList() ??
              [],
      accessories: (json['accessories'] as List<dynamic>?)
              ?.map((x) => AvatarElements.fromJson(x))
              .toList() ??
          [],
      colors: (json['colors'] as List<dynamic>?)
              ?.map((x) => AvatarElements.fromJson(x, key: 'code'))
              .toList() ??
          [],
    );
  }
}

class AvatarElements {
  final int id;
  final String value;

  const AvatarElements({
    required this.id,
    required this.value,
  });

  factory AvatarElements.fromJson(Map<String, dynamic> json, {String? key}) {
    final id = int.tryParse(json['element_id'] ?? '');
    return AvatarElements(
      id: id ?? 0,
      value: json[key ?? 'image'],
    );
  }
}
