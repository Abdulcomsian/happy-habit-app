import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/shared/widgets/custom_button.dart';
import 'package:happy_habit/core/shared/widgets/root_screen.dart';
import 'package:happy_habit/core/shared/widgets/tap_widget.dart';
import 'package:happy_habit/core/theme/typography.dart';

class SubscriptionScreen extends StatelessWidget {
  static const id = '/SubscriptionScreen';

  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RootScreen(
      title: 'Subscription',
      action: TapWidget(
        child: Text(
          'Skip',
          style: context.bodyMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Get unlimited access to our programs.',
              style: context.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Take the first step towards a healthier and happier life.',
              textAlign: TextAlign.center,
            ),
            20.height,
            Container(
              padding: EdgeInsets.all(24.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                children: [
                  5.height,
                  Text('POPULAR'),
                  4.height,
                  Text(
                    'Exercise Class',
                    style: context.titleSmall,
                  ),
                  4.height,
                  Text(
                    '4.99€',
                    style: context.headlineLarge?.copyWith(
                      fontSize: 48.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  30.height,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Text(
                      'Unlock advanced analytics, unlimited social features, 	exclusive customizations, and an ad-free experience.',
                      textAlign: TextAlign.center,
                      style: context.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  20.height,
                  CustomButton(
                    label: 'Subscribe',
                    onPressed: _googlePay,
                  ),
                ],
              ),
            ),
            20.height,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Text(
                'You will be charged \$9.99 (monthly plan) or \$60.99 (annual plan) through your iTunes account. You can cancel at any time if your not satisfied.',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _googlePay() async {}
}
