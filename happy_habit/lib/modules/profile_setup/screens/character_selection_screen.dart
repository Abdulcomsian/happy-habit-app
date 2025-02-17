import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:happy_habit/core/avatar/avatar_provider.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/services/providers.dart';
import 'package:happy_habit/core/shared/widgets/custom_button.dart';
import 'package:happy_habit/core/shared/widgets/root_screen.dart';
import 'package:happy_habit/core/theme/typography.dart';
import 'package:happy_habit/modules/profile_setup/screens/edit_avatar_screen.dart';
import 'package:happy_habit/modules/profile_setup/services/character_attributes.dart';
import 'package:rive/rive.dart';

import '../../auth/services/auth_provider.dart';

class CharacterSelectionScreen extends StatefulWidget {
  static const id = '/CharacterSelectionScreen';

  const CharacterSelectionScreen({super.key});

  @override
  State<CharacterSelectionScreen> createState() => _CharacterSelectionScreenState();
}

class _CharacterSelectionScreenState extends State<CharacterSelectionScreen> {
  final _selectedAvatar = ValueNotifier('');
  final _prov = serviceLocator<AvatarProvider>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _selectedAvatar.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RootScreen(
      title: 'Create Avatar',
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20.r),
        child: ValueListenableBuilder(
          valueListenable: _selectedAvatar,
          builder: (context, selectedAvatar, _) {
            return CustomButton(
              label: 'Create Your Avatar',
              onPressed: selectedAvatar.isEmpty ? null : _createAvatar,
            );
          },
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30.r),
              ),
            ),
            child: ValueListenableBuilder(
              valueListenable: _selectedAvatar,
              builder: (context, selectedAvatar, _) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _Artboard(
                      artboard: _prov.maleArtboard,
                      selected: selectedAvatar == 'male',
                      onTap: () => _selectedAvatar.value = 'male',
                    ),
                    _Artboard(
                      artboard: _prov.femaleArtboard,
                      selected: selectedAvatar == 'female',
                      onTap: () => _selectedAvatar.value = 'female',
                    ),
                  ],
                );
              },
            ),
          ),
          20.height,
          Padding(
            padding: EdgeInsets.only(left: 20.w),
            child: Text(
              'Avatars',
              style: context.bodyLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.w),
            child: Text(
              'Create you own avatars within the app.',
              style: context.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _createAvatar() {
    final prov = serviceLocator<AuthProvider>();
    final attributes = CharacterAttributes(isMale: _selectedAvatar.value == 'male');
    prov.updateUser(characterAttributes: attributes);
    context.pushNamed(EditAvatarScreen.id);
  }
}

class _Artboard extends StatelessWidget {
  final bool selected;
  final Artboard artboard;
  final VoidCallback onTap;

  const _Artboard({
    required this.onTap,
    required this.artboard,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        InkWell(
          onTap: onTap,
          child: SizedBox(
            width: 0.4.sw,
            height: 338.h,
            child: Rive(
              artboard: artboard,
            ),
          ),
        ),
        if (selected)
          Icon(
            Icons.check,
          ),
      ],
    );
  }
}
