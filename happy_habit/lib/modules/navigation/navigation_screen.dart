import 'package:flutter/material.dart';
import 'package:happy_habit/modules/home/home_screen.dart';
import 'package:happy_habit/modules/navigation/navigation_provider.dart';
import 'package:happy_habit/modules/profile/screens/profile_screen.dart';
import 'package:happy_habit/modules/progress/screens/progress_screen.dart';
import 'package:provider/provider.dart';

import '../../core/services/providers.dart';
import '../activity/screens/activity_setup_screen.dart';
import '../progress/screens/progress_tracking_screen.dart';
import 'shared/custom_bottom_navigation_bar.dart';
import 'shared/custom_drawer.dart';

class NavigationScreen extends StatelessWidget {
  static const id = '/NavigationScreen';

  NavigationScreen({super.key}) {
    serviceLocator<NavigationProvider>().storeIsFirstLaunch();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: serviceLocator<NavigationProvider>().onWillPop,
      child: Scaffold(
        body: Consumer<NavigationProvider>(
          builder: (context, prov, _) => IndexedStack(
            index: prov.currentIndex,
            children: [
              HomeScreen(),
              ProgressTrackingScreen(),
              ProgressScreen(),
              ActivitySetupScreen(),
              ProfileScreen(isAppUser: true),
            ],
          ),
        ),
        drawer: CustomDrawer(),
        bottomNavigationBar: const CustomBottomNavigationBar(),
      ),
    );
  }
}
