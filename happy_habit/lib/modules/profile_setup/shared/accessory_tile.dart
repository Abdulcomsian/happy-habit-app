import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/theme/theme_colors.dart';

class AccessoryTile extends StatelessWidget {
  final Color? color;
  final bool isSelected;
  final String accessory;
  final ValueChanged<String> onChanged;

  const AccessoryTile({
    super.key,
    required this.color,
    required this.accessory,
    required this.onChanged,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged.call(accessory),
      child: Container(
        width: 45.r,
        height: 45.r,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            width: 2,
            color: isSelected ? ThemeColor.primary : Colors.transparent,
          ),
        ),
        child: color == null
            ? Align(
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  accessory,
                  width: 50.r,
                  height: 50.r,
                ),
              )
            : isSelected
                ? Icon(Icons.check, size: 40.r)
                : SizedBox.shrink(),
      ),
    );
  }
}
