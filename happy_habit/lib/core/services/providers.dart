import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../modules/home/services/home_provider.dart';

final serviceLocator = GetIt.instance;

void setupLocator() {
  // Register services and repositories here
  serviceLocator.registerLazySingleton(() => HomeProvider());
}

class Providers {
  static List<SingleChildWidget> repositories = [
    // List of repository providers
    ChangeNotifierProvider(create: (_) => serviceLocator<HomeProvider>()),
  ];
}
