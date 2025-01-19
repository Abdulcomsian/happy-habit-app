import 'package:get_it/get_it.dart';
import 'package:happy_habit/modules/auth/services/auth_provider.dart';
import 'package:happy_habit/modules/navigation/navigation_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../modules/home/services/home_provider.dart';
import '../../modules/profile_setup/services/profile_setup_provider.dart';

final serviceLocator = GetIt.instance;

void setupLocator() {
  // Register services and repositories here
  serviceLocator.registerLazySingleton(() => AuthProvider());
  serviceLocator.registerLazySingleton(() => HomeProvider());
  serviceLocator.registerLazySingleton(() => ProfileSetupProvider());
  serviceLocator.registerLazySingleton(() => NavigationProvider());
}

class Providers {
  static List<SingleChildWidget> repositories = [
    // List of repository providers
    ChangeNotifierProvider(create: (_) => serviceLocator<AuthProvider>()),
    ChangeNotifierProvider(create: (_) => serviceLocator<HomeProvider>()),
    ChangeNotifierProvider(create: (_) => serviceLocator<ProfileSetupProvider>()),
    ChangeNotifierProvider(create: (_) => serviceLocator<NavigationProvider>()),
  ];
}
