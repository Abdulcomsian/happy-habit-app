import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:happy_habit/modules/profile_setup/services/app_avatar_elements.dart';

import '../../../core/shared/widgets/circular_bounce_loader.dart';
import '../../../core/shared/widgets/custom_network_image.dart';
import '../../../core/theme/theme_colors.dart';

class AccessoryTile extends StatelessWidget {
  final Color? color;
  final bool isSelected;
  final AvatarElements element;
  final ValueChanged<AvatarElements> onChanged;

  const AccessoryTile({
    super.key,
    required this.color,
    required this.element,
    required this.onChanged,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged.call(element),
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
                child: SvgPicture.network(
                  element.value,
                  width: 50.r,
                  height: 50.r,
                  placeholderBuilder: (context) => CircleBounceLoader(size: 24.r),
                  errorBuilder: (context, error, stackTrace) => Icon(Icons.error_outline, size: 24.r),
                ) ?? CustomNetworkImage(
                  url: element.value,
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
