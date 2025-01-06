
import 'package:hive/hive.dart';

part 'auth_token.g.dart';

@HiveType(typeId: 0)
class AuthToken extends HiveObject {
  @HiveField(0)
  final String _jwtToken;

  @HiveField(1)
  final String _refreshToken;

  AuthToken({required String jwtToken, required String refreshToken})
      : _refreshToken = refreshToken,
        _jwtToken = jwtToken;

  factory AuthToken.fromJson(Map<String, dynamic> json) => AuthToken(
    jwtToken: json['jwtToken'],
    refreshToken: json['refreshToken'],
  );

  String get accessToken {
    return 'Bearer $_jwtToken';
  }

  Map<String, String> get refreshToken {
    return {"refreshToken": _refreshToken};
  }
}