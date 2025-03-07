import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happy_habit/core/shared/widgets/tap_widget.dart';

import '../../../core/constants/avatar_asset_paths.dart';
import '../../../core/services/providers.dart';
import '../../../core/shared/widgets/svg_Icon.dart';
import '../../../core/theme/theme_colors.dart';
import '../../auth/services/auth_provider.dart';

class ElementTypesList extends StatelessWidget {
  final bool isMale;
  final ValueChanged<String> onChanged;
  final ValueNotifier<String> selectedAccessoriesTypes;

  const ElementTypesList({
    super.key,
    required this.isMale,
    required this.onChanged,
    required this.selectedAccessoriesTypes,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(12.r),
        ),
      ),
      child: ValueListenableBuilder(
        valueListenable: selectedAccessoriesTypes,
        builder: (context, types, _) {
          return Wrap(
            alignment: WrapAlignment.end,
            children: List.generate(
              _elements.length,
              (i) {
                final isSelected = _elements[i] == types;
                return TapWidget(
                  // color: Colors.pink,
                  onTap: () => onChanged.call(AvatarIcons.elements[i]),
                  padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 10.h),
                  child: SvgIcon(
                    AvatarIcons.elements[i],
                    width: 20.r,
                    height: 20.r,
                    color: isSelected ? ThemeColor.primary : null,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  List<String> get _elements {
    if (isMale) {
      return AvatarIcons.elements;
    } else {
      // Create a copy of the list and remove the last element
      return List.from(AvatarIcons.elements)..removeLast();
    }
  }
}
