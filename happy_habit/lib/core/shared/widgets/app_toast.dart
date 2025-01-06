import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/theme/typography.dart';

import '../../routes/routes.dart';
import '../../theme/theme_colors.dart';
import 'tap_widget.dart';

enum AppToastType { info, error, success }

class AppToastUI extends StatelessWidget {
  final String msg;
  final int maxLines;
  final AppToastType type;
  final VoidCallback? onAction;

  const AppToastUI({
    super.key,
    this.onAction,
    this.maxLines = 2,
    required this.msg,
    this.type = AppToastType.success,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 12.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          width: 2,
          color: _foregroundColor,
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 70,
            spreadRadius: 10,
            offset: const Offset(0, 3),
            color: Colors.black.withValues(alpha: 200),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            _icon,
            size: 18.r,
            color: _actionIconColor,
          ),
          10.width,
          Expanded(
            child: Text(
              msg,
              overflow: TextOverflow.ellipsis,
              style: context.bodyMedium,
              maxLines: maxLines,
            ),
          ),
          TapWidget(
            onTap: onAction,
            padding: EdgeInsets.all(6.r),
            child: Icon(
              Icons.close,
              size: 10.r,
              color: _foregroundColor,
            ),
          ),
        ],
      ),
    );
  }

  Color? get _actionIconColor {
    switch (type) {
      case AppToastType.success:
        return ThemeColor.success;
      case AppToastType.error:
        return ThemeColor.error;
      default:
        return null;
    }
  }

  Color get _foregroundColor {
    switch (type) {
      case AppToastType.success:
        return ThemeColor.success;
      case AppToastType.error:
        return ThemeColor.error;
      default:
        return ThemeColor.primary;
    }
  }

  IconData get _icon {
    switch (type) {
      case AppToastType.success:
        return CupertinoIcons.checkmark;
      case AppToastType.error:
        return CupertinoIcons.info;
      default:
        return Icons.warning_amber;
    }
  }
}

class AppToast {
  static late FToast _fToast;

  // AppToast() {
  //   fToast = FToast();
  // }

  static void init() {
    _fToast = FToast();
  }

  static void show(
    // BuildContext context,
    String msg, {
    int maxLines = 2,
    AppToastType type = AppToastType.info,
  }) {
    final context = Routes.rootNavigatorKey.currentContext!;
    _fToast.init(context);

    _fToast.showToast(
      child: AppToastUI(
        msg: msg,
        type: type,
        maxLines: maxLines,
        onAction: _fToast.removeQueuedCustomToasts,
      ),
      gravity: ToastGravity.TOP,
      toastDuration: const Duration(milliseconds: 3000),
    );
  }
}

extension ShowAppToast on BuildContext {}

// class AppToast {
//   FToast fToast = FToast();
//
//   AppToast() {
//     fToast.init(Routers.rootNavigatorKey.currentContext!);
//   }
//
//   void showToast(
//     String msg, {
//     AppToastType type = AppToastType.success,
//   }) {
//     fToast.showToast(
//       child: AppToastUI(
//         msg: msg,
//         type: type,
//         onAction: fToast.removeQueuedCustomToasts,
//       ),
//       gravity: ToastGravity.TOP,
//     );
//   }
// }
