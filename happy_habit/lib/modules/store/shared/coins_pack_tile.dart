import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:happy_habit/core/constants/asset_paths.dart';
import 'package:happy_habit/core/extensions/int_extensions.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/theme/typography.dart';
import 'package:happy_habit/modules/store/services/coins_pack.dart';

class CoinsPackTile extends StatelessWidget {
  final bool selected;
  final CoinsPack pack;
  final ValueChanged<CoinsPack> onTap;

  const CoinsPackTile({
    super.key,
    required this.pack,
    required this.onTap,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap.call(pack),
      child: Stack(
        fit: StackFit.passthrough,
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            margin: EdgeInsets.only(top: 2.r, right: 2.r),
            padding: EdgeInsets.all(7.r),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                10.height,
                SvgPicture.asset(
                  AppIcons.multiCoins,
                  width: 40.r,
                  height: 40.r,
                ),
                Text(
                  pack.quantity.toString(),
                  style: context.bodyMedium?.copyWith(
                    color: Color(0xff0f8200),
                  ),
                ),
                Text(
                  pack.price.formatPrice(),
                  style: context.bodyMedium?.copyWith(
                    color: Color(0xff0f8200),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: Color(0xff1BD003),
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Text(
                pack.tag,
                style: context.labelMedium?.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
