import '../../../core/avatar/avatar_provider.dart';
import '../../../core/services/providers.dart';
import '../../profile_setup/services/avatar_attributes.dart';

class AppUser {
  final int id;
  bool areGoalsReady;
  String name, email;
  String? username, imageUrl;

  // String? gender, username, imageUrl;
  AvatarAttributes? avatarAttributes;

  AppUser({
    required this.id,
    required this.name,
    required this.email,
    // required this.gender,
    required this.imageUrl,
    required this.username,
    required this.areGoalsReady,
    required this.avatarAttributes,
  });

  // AvatarAttributes? avatarAttributes,
  // }) : avatarAttributes = avatarAttributes ?? AvatarAttributes();

  factory AppUser.fromJson(Map<String, dynamic> json) {
    final appUser = AppUser(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      // gender: json['gender'],
      imageUrl: json['imageUrl'],
      username: json['username'],
      areGoalsReady: json['areGoalsReady'] ?? false,
      avatarAttributes: json['avatar'] != null ? AvatarAttributes.fromJson(json['avatar']) : null,
    );
    serviceLocator<AvatarProvider>().initializeUserArtboard(avatarAttributes: appUser.avatarAttributes);
    return appUser;
  }

// bool get isMaleCharacter => gender == 'male';
}
