
import 'package:hive/hive.dart';

part 'auth_token.g.dart';

@HiveType(typeId: 0)
class AuthToken extends HiveObject {
  @HiveField(0)
  final String _jwtToken;

  AuthToken({required String jwtToken})
      : _jwtToken = jwtToken;

  factory AuthToken.fromJson(Map<String, dynamic> json) => AuthToken(
    jwtToken: json['access_token'],
  );

  String get token {
    return _jwtToken;
  }

  String get accessToken {
    return 'Bearer $_jwtToken';
  }
}