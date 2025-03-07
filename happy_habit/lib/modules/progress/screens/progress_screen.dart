import 'package:flutter/material.dart' as m;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:happy_habit/core/avatar/avatar_provider.dart';
import 'package:happy_habit/core/constants/asset_paths.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/services/providers.dart';
import 'package:happy_habit/core/shared/widgets/tap_widget.dart';
import 'package:happy_habit/core/shared/widgets/user_score_widgets.dart';
import 'package:happy_habit/core/theme/theme_colors.dart';
import 'package:happy_habit/modules/auth/services/auth_provider.dart';
import 'package:happy_habit/modules/navigation/navigation_provider.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

import '../../../core/shared/widgets/custom_outlined_button.dart';

class ProgressScreen extends StatelessWidget {
  static const id = 'ProgressScreen';

  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.loose,
        children: [
          m.Image.asset(
            AppAssets.bg,
            width: 1.sw,
            height: 1.sh,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 60.h,
            width: 1.sw,
            height: 1.sh,
            child: Column(
              children: [
                Consumer<AuthProvider>(
                  builder: (context, prov, _) {
                    return SizedBox(
                      width: 198.w,
                      height: 0.73.sh,
                      child: Consumer<AvatarProvider>(
                        builder: (context, prov, _) {
                          return Rive(
                            artboard: prov.userArtboard,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    );
                  },
                ),
                30.height,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: CustomOutlinedButton(
                    label: 'Progress Tracking',
                    foregroundColor: ThemeColor.fontBlack,
                    onPressed: () => serviceLocator<NavigationProvider>().changeIndex(3),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            left: 20.w,
            top: kToolbarHeight.h,
            child: TapWidget(
              onTap: Scaffold.of(context).openDrawer,
              child: SvgPicture.asset(
                AppIcons.drawer,
              ),
            ),
          ),
          Positioned(
            right: 20.w,
            top: kToolbarHeight.h,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                LevelWidget(),
                5.height,
                CoinWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
