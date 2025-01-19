import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:happy_habit/core/constants/asset_paths.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/shared/widgets/custom_button.dart';
import 'package:happy_habit/core/shared/widgets/root_screen.dart';
import 'package:happy_habit/core/theme/typography.dart';
import 'package:happy_habit/modules/profile_setup/screens/edit_avatar_screen.dart';

class AvatarSelectionScreen extends StatefulWidget {
  static const id = 'AvatarSelectionScreen';

  const AvatarSelectionScreen({super.key});

  @override
  State<AvatarSelectionScreen> createState() => _AvatarSelectionScreenState();
}

class _AvatarSelectionScreenState extends State<AvatarSelectionScreen> {
  final _selectedAvatar = ValueNotifier('');

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
              onPressed: selectedAvatar.isEmpty
                  ? null
                  : () => context.pushNamed(EditAvatarScreen.id, extra: {
                        'avatar': _selectedAvatar.value,
                      }),
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
                    Stack(
                      children: [
                        InkWell(
                          onTap: () => _selectedAvatar.value = DummyIcons.male,
                          child: Image.asset(
                            DummyIcons.male,
                            width: 126.w,
                            height: 384.h,
                            alignment: Alignment.bottomCenter,
                          ),
                        ),
                        if (selectedAvatar == DummyIcons.male)
                          Positioned(
                            right: 0,
                            child: Icon(
                              Icons.check_circle_outline,
                            ),
                          ),
                      ],
                    ),
                    Stack(
                      children: [
                        InkWell(
                          onTap: () => _selectedAvatar.value = DummyIcons.female,
                          child: Image.asset(
                            DummyIcons.female,
                            width: 138.w,
                            height: 338.h,
                            alignment: Alignment.bottomCenter,
                          ),
                        ),
                        if (selectedAvatar == DummyIcons.female)
                          Positioned(
                            right: 0,
                            child: Icon(
                              Icons.check_circle_outline,
                            ),
                          ),
                      ],
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
}
