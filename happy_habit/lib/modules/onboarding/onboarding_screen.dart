import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/shared/widgets/custom_switcher.dart';
import 'package:happy_habit/core/shared/widgets/tap_widget.dart';
import 'package:happy_habit/core/theme/theme_colors.dart';
import 'package:happy_habit/core/theme/typography.dart';
import 'package:happy_habit/modules/auth/screens/welcome_screen.dart';
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
                          onTap: () => context.pushReplacementNamed(WelcomeScreen.id),
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
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            child: ValueListenableBuilder(
              valueListenable: _currentIndex,
              builder: (context, i, _) => Indicator(
                length: _data.length,
                currentIndex: i,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  final int length;
  final int currentIndex;

  const Indicator({
    super.key,
    required this.length,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(length, (index) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: 4.0),
          padding: EdgeInsets.symmetric(
            // vertical: currentIndex == index ? 7.0 : 4,
            vertical: 5,
            horizontal: currentIndex == index ? 10.0 : 5,
          ),
          decoration: BoxDecoration(
            // shape: BoxShape.circle,
            borderRadius: BorderRadius.circular(10),
            color: currentIndex == index ? ThemeColor.primary : Colors.grey,
          ),
        );
      }),
    );
  }
}
