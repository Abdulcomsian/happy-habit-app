import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:happy_habit/core/constants/asset_paths.dart';
import 'package:happy_habit/core/extensions/int_extensions.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/theme/typography.dart';
import 'package:happy_habit/modules/store/screens/cart_screen.dart';

import '../services/store_item.dart';

class StoreItemTile extends StatelessWidget {
  final bool selected;
  final StoreItem item;
  final bool areWallpapers;
  final ValueChanged<StoreItem> onTap;

  const StoreItemTile({
    super.key,
    required this.item,
    required this.onTap,
    this.selected = false,
    this.areWallpapers = false,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.r),
      child: InkWell(
        // onTap: () => onTap.call(item),
        onTap: () => context.pushNamed(CartScreen.id, extra: {
          'item': item,
        }),
        child: Stack(
          fit: StackFit.loose,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: Container(
                        padding: areWallpapers ? null : EdgeInsets.all(12.r),
                        decoration: BoxDecoration(
                          color: Color(0xffF5F7FA),
                        ),
                        child: Image.asset(
                          item.imageUrl,
                          width: 0.5.sw,
                          fit: areWallpapers ? BoxFit.cover : null,
                        ),
                      ),
                    ),
                  ),
                  10.height,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text(
                      item.name,
                      style: context.bodySmall,
                    ),
                  ),
                  3.height,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text(
                      item.label,
                      style: context.bodySmall,
                    ),
                  ),
                  10.height,
                  Row(
                    children: [
                      16.width,
                      SvgPicture.asset(
                        AppIcons.coins,
                        width: 24.r,
                        height: 24.r,
                      ),
                      3.width,
                      Text(
                        item.price.toString(),
                        style: context.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  10.height,
                ],
              ),
            ),
            Positioned(
              top: -25,
              left: -35,
              width: 80.r,
              height: 60.r,
              child: Transform.rotate(
                angle: -45.degree,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.only(bottom: 5.h),
                  color: item.tag.toLowerCase().contains('sale')
                      ? Color(0xffFF5A5A)
                      : Color(0xffFFC618),
                  child: Text(
                    item.tag,
                    style: context.labelSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
            // Positioned(
            //   top: 15,
            //   left: 7,
            //   child: Transform.rotate(
            //     angle: -45.degree,
            //     child: Text(
            //       item.tag,
            //       style: context.labelSmall?.copyWith(
            //         color: Colors.white,
            //         fontWeight: FontWeight.w700,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
