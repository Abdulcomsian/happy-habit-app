import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/avatar_asset_paths.dart';
import '../../../core/services/providers.dart';
import '../../../core/shared/widgets/svg_Icon.dart';
import '../../../core/theme/theme_colors.dart';
import '../../auth/services/auth_provider.dart';

class ElementTypesList extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final ValueNotifier<String> selectedAccessoriesTypes;

  const ElementTypesList({
    super.key,
    required this.onChanged,
    required this.selectedAccessoriesTypes,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
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
            spacing: 10.w,
            alignment: WrapAlignment.end,
            children: List.generate(
              _elements.length,
              (i) {
                final isSelected = _elements[i] == types;
                return InkWell(
                  onTap: () => onChanged.call(AvatarIcons.elements[i]),
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
    final attributes = serviceLocator<AuthProvider>().appUser!.characterAttributes!;
    if (attributes.isMale) {
      return AvatarIcons.elements;
    } else {
      AvatarIcons.elements.removeLast();
      return AvatarIcons.elements;
    }
  }
}
