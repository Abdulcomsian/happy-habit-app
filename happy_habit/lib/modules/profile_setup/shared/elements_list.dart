import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happy_habit/core/avatar/avatar_provider.dart';
import 'package:happy_habit/modules/profile_setup/services/app_avatar_elements.dart';

import '../../../core/services/logger.dart';
import '../../../core/services/providers.dart';
import '../../auth/services/auth_provider.dart';
import 'avatar_element_tile.dart';

class ElementsList extends StatelessWidget {
  final ValueNotifier<String> elementType;
  final Function(int, String) onChanged;
  final ValueNotifier<Map<String, AvatarElements>> selectedElement;

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
              itemCount: _elements(type).length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 10.r,
                crossAxisSpacing: 10.r,
                // crossAxisCount: type == 'face' ? 5 : 4,
              ),
              itemBuilder: (context, i) {
                Color? color;
                final element = _elements(type)[i];

                // Logger.logWarning('type: $type');
                // if (type == 'face') {
                //   color = Color(int.parse(element.value.replaceFirst('#', '0xff')));
                // }

                return ValueListenableBuilder(
                  valueListenable: selectedElement,
                  builder: (context, selectedItems, _) {
                    final isSelected = selectedElement.value[type] == element;
                    return AccessoryTile(
                      color: color,
                      element: element,
                      isSelected: isSelected,
                      onChanged: (value) => _maintainAccessory(element.id, element),
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

  void _maintainAccessory(int id, AvatarElements accessory) {
    selectedElement.value = Map.from(selectedElement.value)..[elementType.value] = accessory;

    onChanged.call(id, elementType.value);
  }

// Get the correct accessories based on avatar type and selected accessory name
  List<AvatarElements> _elements(String elementType) {
    final attributes = serviceLocator<AuthProvider>().appUser!.characterAttributes!;
    if (attributes.isMale) {
      return maleElements(elementType); // Return male-specific accessories
    } else {
      return femaleElements(elementType); // Return female-specific accessories
    }
  }

  // Function to get male elements based on element name
  List<AvatarElements> maleElements(String accessoryType) {
    final prov = serviceLocator<AvatarProvider>();
    switch (accessoryType) {
      case 'hairs':
        return prov.maleElements.hairs;
      case 'top':
        return prov.maleElements.clothes;
      case 'eye':
        return prov.maleElements.eyes;
      case 'face':
        return prov.maleElements.faceShape;
      case 'nose':
        return prov.maleElements.noses;
      case 'color':
        return prov.maleElements.colors;
      case 'mouth':
        return prov.maleElements.mouth;
      case 'beard':
        return prov.maleElements.beards;
      case 'eyebrow':
        return prov.maleElements.eyebrows;
      default:
        return [];
    }
  }

  // Function to get female elements based on element name
  List<AvatarElements> femaleElements(String elementType) {
    final prov = serviceLocator<AvatarProvider>();
    switch (elementType) {
      case 'hairs':
        return prov.femaleElements.hairs;
      case 'top':
        return prov.femaleElements.shirts;
      case 'eye':
        return prov.femaleElements.eyes;
      case 'eyebrow':
        return prov.femaleElements.eyebrows;
      case 'nose':
        return prov.femaleElements.noses;
      case 'face':
        return prov.femaleElements.faceShape;
      case 'color':
        return prov.femaleElements.colors;
      case 'mouth':
        return prov.femaleElements.mouth;
      case 'top':
        return prov.femaleElements.clothes;
      default:
        return [];
    }
  }
}
