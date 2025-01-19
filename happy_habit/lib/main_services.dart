import 'package:firebase_core/firebase_core.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'core/environment/environment_config.dart';
import 'modules/auth/services/auth_token.dart';

class MainServices {
  /// Initializes Firebase and handles errors if it's already initialized.
  static Future<void> initializeFirebase() async {
    await Firebase.initializeApp(
      // options: Environment.isProduction
      //     ? DefaultFirebaseOptionsProduction.currentPlatform
      //     : DefaultFirebaseOptionsStaging.currentPlatform,
    );
  }

  /// Initializes Hive and registers the necessary adapters.
  static Future<void> setUpHive() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocDir.path);

    Hive.registerAdapter(AuthTokenAdapter());
  }
}
