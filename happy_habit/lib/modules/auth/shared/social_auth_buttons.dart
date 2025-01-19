import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';

import '../../../core/constants/asset_paths.dart';
import '../../../core/shared/widgets/custom_button.dart';

class SocialAuthButtons extends StatelessWidget {
  const SocialAuthButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomButton(
          onPressed: () {},
          color: Colors.white,
          label: 'Continue with Google',
          icon: SvgPicture.asset(AppIcons.google),
        ),
        10.height,
        CustomButton(
          onPressed: () {},
          color: Colors.white,
          label: 'Continue with Facebook',
          icon: SvgPicture.asset(AppIcons.facebook),
        ),
        if (Platform.isIOS) ...[
          10.height,
          CustomButton(
            onPressed: () {},
            color: Colors.white,
            label: 'Continue with Apple',
            icon: SvgPicture.asset(AppIcons.apple),
          ),
        ]
      ],
    );
  }
}
