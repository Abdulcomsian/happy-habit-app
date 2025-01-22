import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/shared/widgets/custom_button.dart';
import 'package:happy_habit/core/theme/typography.dart';
import 'package:happy_habit/modules/navigation/navigation_screen.dart';
import 'package:happy_habit/modules/store/screens/purchase_confirmation_screen.dart';

class OrderPriceDetails extends StatelessWidget {
  const OrderPriceDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Summary',
            style: context.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          16.height,
          Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order Total',
                style: context.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text('228.80'),
            ],
          ),
          10.height,
          Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Items Discount',
                style: context.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text('- 28.80'),
            ],
          ),
          10.height,
          Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Coupon Discount',
                style: context.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text('-15.80'),
            ],
          ),
          10.height,
          Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Shipping',
                style: context.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text('Free'),
            ],
          ),
          15.height,
          Divider(),
          10.height,
          Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: context.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '50.00',
                style: context.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          25.height,
          CustomButton(
            label: 'Pay',
            onPressed: () => context.pushReplacementNamed(PurchaseConfirmationScreen.id),
          ),
        ],
      ),
    );
  }
}
