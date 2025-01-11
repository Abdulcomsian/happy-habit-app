import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:happy_habit/core/constants/assets_path.dart';
import 'package:happy_habit/core/shared/widgets/tap_widget.dart';

class ProgressScreen extends StatelessWidget {
  static const id = 'ProgressScreen';

  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Center(
          child: TapWidget(
            onTap: Scaffold.of(context).openDrawer,
            child: SvgPicture.asset(
              AppIcons.drawer,
            ),
          ),
        ),
      ),
    );
  }
}
