import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'core/environment/config.dart';
import 'core/services/providers.dart';
import 'main_serviecs.dart';
import 'my_app.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  final Environment environment = Environment();
  String fileName = await environment.getFileNameFromEnvironment();

  await Future.wait<dynamic>([
    dotenv.load(fileName: fileName),
    MainServices.setUpHive(),
  ]);


  setupLocator();
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (value) => runApp(const MyApp()),
  );
}
