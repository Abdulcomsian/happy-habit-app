import 'package:flutter/material.dart';
import 'package:happy_habit/core/constants/avatar_asset_paths.dart';
import 'package:happy_habit/core/extensions/string_extensions.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/theme/theme_colors.dart';
import 'package:happy_habit/modules/profile_setup/shared/accessories_list.dart';
import 'package:happy_habit/modules/profile_setup/shared/accessory_types_list.dart';

import '../shared/avatar_section.dart';

class EditAvatarScreen extends StatefulWidget {
  static const id = 'EditAvatarScreen';

  final String avatar;

  const EditAvatarScreen({super.key, required this.avatar});

  @override
  State<EditAvatarScreen> createState() => _EditAvatarScreenState();
}

class _EditAvatarScreenState extends State<EditAvatarScreen> {
  String _avatar = '';
  final _selectedAccessoriesTypes = ValueNotifier(AvatarIcons.allIcons.first);
  final _accessoryType = ValueNotifier(AvatarIcons.allIcons.first.basenameWithoutExtension());

  @override
  void initState() {
    super.initState();
    _avatar = widget.avatar.basenameWithoutExtension();
  }

  void _setAccessory(String path) {
    _selectedAccessoriesTypes.value = path;
    _accessoryType.value = path.basenameWithoutExtension();
  }

  @override
  void dispose() {
    _accessoryType.dispose();
    _selectedAccessories.dispose();
    _selectedAccessoriesTypes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.background,
      body: Column(
        children: [
          AvatarSection(avatar: widget.avatar),
          13.height,
          Align(
            alignment: Alignment.centerRight,
            child: AccessoryTypesList(
              onChanged: _setAccessory,
              selectedAccessoriesTypes: _selectedAccessoriesTypes,
            ),
          ),
          13.height,
          AccessoriesList(
            avatar: _avatar,
            accessoryType: _accessoryType,
            selectedAccessories: _selectedAccessories,
          ),
        ],
      ),
    );
  }

  final ValueNotifier<Map<String, String>> _selectedAccessories = ValueNotifier({});
}
