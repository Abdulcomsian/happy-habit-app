import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happy_habit/core/routes/routes.dart';

import 'circular_bounce_loader.dart';

class FullScreenLoader extends StatelessWidget {
  final double? height;

  const FullScreenLoader({
    super.key,
    this.height,
  });


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return Future.value(false);
      },
      child: Container(
        height: height ?? 1.sh,
        width: 1.sw,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          backgroundBlendMode: BlendMode.darken,
        ),
        child: const Center(
          // child: loader ?? const PlatformLoader(),
          child: CircleBounceLoader(),
        ),
      ),
    );
  }
}

class AppLoader {
  static final _context = Routes.rootNavigatorKey.currentContext!;

  static showFullScreenLoader() {
    showDialog(
      barrierDismissible: false,
      context: _context,
      builder: (_) => const FullScreenLoader(),
    );
  }

  static hideLoader() => Navigator.pop(_context);
}
