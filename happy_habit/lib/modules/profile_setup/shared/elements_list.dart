import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happy_habit/core/avatar/avatar_provider.dart';
import 'package:happy_habit/modules/profile_setup/services/character_accessories.dart';

import '../../../core/services/providers.dart';
import '../../auth/services/auth_provider.dart';
import 'accessory_tile.dart';

class ElementsList extends StatelessWidget {
  final ValueNotifier<String> elementType;
  final Function(int, String) onChanged;
  final ValueNotifier<Map<String, Accessory>> selectedElement;

  const ElementsList({
    super.key,
    required this.onChanged,
    required this.elementType,
    required this.selectedElement,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.white,
        child: ValueListenableBuilder(
          valueListenable: elementType,
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
                  color = Color(int.parse(accessory.value.replaceFirst('#', '0xff')));
                }

                return ValueListenableBuilder(
                  valueListenable: selectedElement,
                  builder: (context, selectedItems, _) {
                    final isSelected = selectedElement.value[type] == accessory;
                    return AccessoryTile(
                      color: color,
                      accessory: accessory,
                      isSelected: isSelected,
                      onChanged: (value) => _maintainAccessory(accessory.id, accessory),
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

  void _maintainAccessory(int id, Accessory accessory) {
    selectedElement.value = Map.from(selectedElement.value)..[elementType.value] = accessory;

    onChanged.call(id, elementType.value);
  }

// Get the correct accessories based on avatar type and selected accessory name
  List<Accessory> _accessories(String accessoryType) {
    final attributes = serviceLocator<AuthProvider>().appUser!.characterAttributes!;
    if (attributes.isMale) {
      return maleAccessories(accessoryType); // Return male-specific accessories
    } else {
      return femaleAccessories(accessoryType); // Return female-specific accessories
    }
  }

  // Function to get male accessories based on accessory name
  List<Accessory> maleAccessories(String accessoryType) {
    final prov = serviceLocator<AvatarProvider>();
    switch (accessoryType) {
      case 'hairs':
        return prov.accessories.hairs;
      case 'top':
        return prov.accessories.shirts;
      case 'eye':
        return prov.accessories.eyes;
      case 'face':
        return prov.accessories.colors;
      case 'beard':
        return prov.accessories.beards;
      default:
        return [];
    }
  }

  // Function to get female accessories based on accessory name
  List<Accessory> femaleAccessories(String accessoryType) {
    final prov = serviceLocator<AvatarProvider>();
    switch (accessoryType) {
      case 'hairs':
        return prov.accessories.hairs;
      case 'top':
        return prov.accessories.shirts;
      case 'eye':
        return prov.accessories.eyes;
      case 'face':
        return prov.accessories.colors;
      default:
        return [];
    }
  }
}
