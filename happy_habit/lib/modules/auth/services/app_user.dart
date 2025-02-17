import 'package:happy_habit/core/extensions/data_parsing_extension.dart';

import '../../profile_setup/services/character_attributes.dart';

class AppUser {
  final int id;
  bool areGoalsReady;
  String name, email;
  String? username, imageUrl;

  // String? gender, username, imageUrl;
  CharacterAttributes? characterAttributes;

  AppUser({
    required this.id,
    required this.name,
    required this.email,
    // required this.gender,
    required this.imageUrl,
    required this.username,
    required this.areGoalsReady,
    required this.characterAttributes,
  });

  //   CharacterAttributes? characterAttributes,
  // }) : characterAttributes = characterAttributes ?? CharacterAttributes();

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      // gender: json['gender'],
      imageUrl: json['imageUrl'],
      username: json['username'],
      areGoalsReady: json['areGoalsReady'] ?? false,
      characterAttributes: json.fromJsonDynamic(
          'characterAttributes', (data) => CharacterAttributes.fromJson(data)),
      // characterAttributes: json['characterAttributes'] != null
      //     ? CharacterAttributes.fromJson(json['characterAttributes'])
      //     : null,
    );
  }

// bool get isMaleCharacter => gender == 'male';
}
