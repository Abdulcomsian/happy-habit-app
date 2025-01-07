import 'package:flutter/material.dart';
import 'package:happy_habit/modules/auth/shared/verify_otp_bottom_sheet.dart';

class VerifyOtpNavigation {
  static Future<bool?> openVerifyBottomSheet(BuildContext context, String email) {
    return Navigator.of(context).push<bool>(
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 700),
        reverseTransitionDuration: Duration(milliseconds: 700),
        pageBuilder: (BuildContext context, Animation<double> animation, _) {
          return VerifyOtpBottomSheet(email: email);
        },
        transitionsBuilder: (BuildContext context, Animation<double> animation, _, Widget child) {
          final offsetAnimation = Tween<Offset>(
            begin: const Offset(0, 1),
            end: const Offset(0, 0),
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            ),
          );

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
        opaque: false,
        barrierDismissible: true,
        barrierColor: Colors.black.withAlpha(128), // 0.5 opacity
      ),
    );
  }
}


// class VerifyOtpNavigation {
//   static void openVerifyBottomSheet(BuildContext context, String email) {
//     Navigator.of(context).push(
//       PageRouteBuilder(
//         transitionDuration: Duration(milliseconds: 700),
//         reverseTransitionDuration: Duration(milliseconds: 700),
//         pageBuilder: (BuildContext context, Animation<double> animation, _) {
//           return VerifyOtpBottomSheet(email: email);
//         },
//         transitionsBuilder: (BuildContext context, Animation<double> animation, _, Widget child) {
//           final offsetAnimation = Tween<Offset>(
//             begin: const Offset(0, 1),
//             end: const Offset(0, 0),
//           ).animate(
//             CurvedAnimation(
//               parent: animation,
//               curve: Curves.easeInOut,
//             ),
//           );
//
//           return SlideTransition(
//             position: offsetAnimation,
//             child: child,
//           );
//         },
//         opaque: false,
//         barrierDismissible: true,
//         barrierColor: Colors.black.withValues(alpha: 0.5),
//       ),
//     );
//   }
// }
