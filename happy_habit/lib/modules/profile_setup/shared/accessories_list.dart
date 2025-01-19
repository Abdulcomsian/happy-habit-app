import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/avatar_asset_paths.dart';
import '../../../core/services/logger.dart';
import '../../../core/theme/theme_colors.dart';
import 'accessory_tile.dart';

class AccessoriesList extends StatelessWidget {
  final String avatar;
  final ValueNotifier<String> accessoryType;
  final ValueNotifier<Map<String, String>> selectedAccessories;

  const AccessoriesList({
    super.key,
    required this.avatar,
    required this.accessoryType,
    required this.selectedAccessories,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.white,
        child: ValueListenableBuilder(
          valueListenable: accessoryType,
          builder: (context, type, _) {
            return GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.all(20.r),
              itemCount: _accessories(type).length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 10.r,
                crossAxisSpacing: 10.r,
                crossAxisCount: type == 'face' ? 5 : 4,
              ),
              itemBuilder: (context, i) {
                Color? color;
                final accessory = _accessories(type)[i];

                if (type == 'face') {
                  color = Color(int.parse(accessory.replaceFirst('#', '0xff')));
                }

                return ValueListenableBuilder(
                  valueListenable: selectedAccessories,
                  builder: (context, selectedItems, _) {
                    final isSelected = selectedAccessories.value[type] == accessory;
                    return AccessoryTile(
                      color: color,
                      accessory: accessory,
                      isSelected: isSelected,
                      onChanged: _maintainAccessory,
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _maintainAccessory(String accessory) {
    selectedAccessories.value = Map.from(selectedAccessories.value)
      ..[accessoryType.value] = accessory;

    Logger.logWarning(accessory);
    Logger.logWarning(selectedAccessories.value);
  }

// Get the correct accessories based on avatar type and selected accessory name
  List<String> _accessories(String accessoryType) {
    if (avatar == 'male') {
      return maleAccessories(accessoryType); // Return male-specific accessories
    } else {
      return femaleAccessories(accessoryType); // Return female-specific accessories
    }
  }

  // Function to get male accessories based on accessory name
  List<String> maleAccessories(String accessoryType) {
    switch (accessoryType) {
      case 'hairs':
        return AvatarIcons.maleHairs;
      case 'tops':
        return AvatarIcons.maleTops;
      case 'eye':
        return AvatarIcons.glasses;
      case 'face':
        return AvatarColors.colors;
      default:
        return [];
    }
  }

  // Function to get female accessories based on accessory name
  List<String> femaleAccessories(String accessoryType) {
    switch (accessoryType) {
      case 'hairs':
        return AvatarIcons.femaleHairs;
      case 'top':
        return AvatarIcons.femaleTops;
      case 'eye':
        return AvatarIcons.glasses;
      case 'face':
        return AvatarColors.colors;
      default:
        return [];
    }
  }
}
