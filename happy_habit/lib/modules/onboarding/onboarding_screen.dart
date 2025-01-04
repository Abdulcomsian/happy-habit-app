import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/shared/widgets/custom_switcher.dart';
import 'package:happy_habit/core/shared/widgets/tap_widget.dart';
import 'package:happy_habit/core/theme/typography.dart';
import 'package:happy_habit/modules/auth/screens/login_screen.dart';
import 'package:happy_habit/modules/onboarding/onboarding_meta_model.dart';

import '../../core/constants/assets_path.dart';

class OnboardingScreen extends StatefulWidget {
  static const id = '/OnboardingScreen';

  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _currentIndex = ValueNotifier(0);
  final List<OnboardingMeta> _data = [];

  @override
  void initState() {
    super.initState();
    _data.addAll(OnboardingMeta.data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.loose,
        children: [
          ValueListenableBuilder(
            valueListenable: _currentIndex,
            builder: (context, i, _) {
              return CustomSwitcher(
                key: ValueKey(_data[i].image),
                child: Image.asset(
                  _data[i].image,
                  width: 1.sw,
                  height: 1.sh,
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
          Positioned(
            bottom: 0,
            width: 1.sw,
            height: 1.sh,
            child: PageView.builder(
              itemCount: _data.length,
              onPageChanged: (value) => _currentIndex.value = value,
              itemBuilder: (context, i) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _data[i].title,
                      style: context.headlineMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    8.height,
                    Flex(
                      direction: Axis.horizontal,
                      children: [
                        Expanded(
                          child: Text(
                            _data[i].description,
                            style: context.bodyMedium?.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        TapWidget(
                          onTap: () => context.pushReplacementNamed(LoginScreen.id),
                          child: SvgPicture.asset(
                            AppIcons.login,
                          ),
                        ),
                      ],
                    ),
                    60.height,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
