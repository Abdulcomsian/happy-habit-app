import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:happy_habit/core/constants/asset_paths.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/routes/routes.dart';
import 'package:happy_habit/core/shared/widgets/custom_button.dart';
import 'package:happy_habit/core/shared/widgets/root_screen.dart';
import 'package:happy_habit/core/theme/theme_colors.dart';
import 'package:happy_habit/core/theme/typography.dart';
import 'package:happy_habit/modules/navigation/navigation_screen.dart';

class PurchaseConfirmationScreen extends StatelessWidget {
  static const id = 'PurchaseConfirmationScreen';

  const PurchaseConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: RootScreen(
        hideHeader: true,
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(20.r),
          child: CustomButton(
            label: 'Back To Home',
            onPressed: () => context.goNamed(NavigationScreen.id),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppIcons.purchaseSuccess,
                width: 245.w,
                height: 196.h,
              ),
              80.height,
              Text(
                'Thank you',
                style: context.headlineSmall?.copyWith(
                  color: ThemeColor.primary,
                ),
              ),
              16.height,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: context.richText(
                  textAlign: TextAlign.center,
                  'Your Order will be delivered with invoice *#9ds69hs*. You can track the delivery in the order section.',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
