import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:happy_habit/core/constants/asset_paths.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/shared/widgets/root_screen.dart';
import 'package:happy_habit/core/shared/widgets/tap_widget.dart';
import 'package:happy_habit/core/theme/typography.dart';
import 'package:happy_habit/modules/store/services/store_item.dart';
import 'package:happy_habit/modules/store/shared/counter_widget.dart';

import '../shared/order_price_details.dart';

class CartScreen extends StatefulWidget {
  static const id = 'CartScreen';

  // final List<StoreItem> items;
  // final List<CoinsPack> packs;
  final StoreItem item;

  // final CoinsPack? pack;

  const CartScreen({
    super.key,
    required this.item,
    // required this.pack,
    // required this.items,
    // required this.packs,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final ValueNotifier<int> _initialCount = ValueNotifier(1);

  @override
  void dispose() {
    _initialCount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RootScreen(
      title: 'Your Cart',
      bottomNavigationBar: OrderPriceDetails(),
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        children: [
          SizedBox(
            height: 76.r,
            child: Flex(
              direction: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 76.r,
                  height: 76.r,
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                  child: Image.asset(
                    widget.item.imageUrl,
                  ),
                ),
                10.width,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.item.name,
                          style: context.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        // 4.height,
                        Text(widget.item.label),
                      ],
                    ),
                    Text(
                      widget.item.price.toString(),
                      style: context.titleSmall,
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TapWidget(
                      onTap: () => Navigator.pop(context),
                      child: SvgPicture.asset(
                        AppIcons.closeCircle,
                        width: 20.r,
                        height: 20.r,
                      ),
                    ),
                    CounterWidget(
                      initialCount: _initialCount,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
