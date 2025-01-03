import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'core/routes/routes.dart';
import 'core/services/providers.dart';
import 'core/theme/theme_preference.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => MultiProvider(
        providers: Providers.repositories,
        child: MaterialApp.router(
          title: 'Happy Habit',
          debugShowCheckedModeBanner: false,
          theme: ThemePreferences.getAppTheme(context),
          routerDelegate: Routes.routers.routerDelegate,
          routeInformationParser: Routes.routers.routeInformationParser,
          routeInformationProvider: Routes.routers.routeInformationProvider,
        ),
      ),
    );
  }
}
