import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'modules/auth/services/auth_token.dart';

class MainServices {
  /// Initializes Hive and registers the necessary adapters.
  static Future<void> setUpHive() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocDir.path);

    Hive.registerAdapter(AuthTokenAdapter());
  }
}
