import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:happy_habit/core/services/providers.dart';
import 'package:happy_habit/core/shared/helper_functions/media/media_provider.dart';
import 'package:happy_habit/core/shared/helper_functions/media/music_services.dart';
import 'package:happy_habit/core/shared/widgets/tap_widget.dart';
import 'package:happy_habit/core/theme/theme_colors.dart';

enum MusicFlavors {
  none,
  music,
  piano,
  rain,
  flower;

  String get path => 'musics/$name.mp3';
  String get icon => 'assets/icons/$name.svg';
  String get url => serviceLocator<MediaProvider>().musics[name]!;
}

class MusicSelectionPopup extends StatelessWidget {
  final MusicFlavors selectedMusic;
  final ValueChanged<MusicFlavors> onChanged;

  const MusicSelectionPopup({
    super.key,
    required this.onChanged,
    required this.selectedMusic,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: 311.r,
        height: 300.r,
        child: Padding(
          padding: EdgeInsets.all(40.r),
          child: GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: _musics.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1,
              mainAxisSpacing: 30.h,
              crossAxisSpacing: 45.w,
            ),
            itemBuilder: (context, i) => SizedBox(
              width: 92.r,
              height: 92.r,
              child: TapWidget(
                radius: 100,
                padding: EdgeInsets.all(12.r),
                color: ThemeColor.backgroundV2,
                onTap: () => _musicManagement(context, _musics[i]),
                child: Center(
                  child: SvgPicture.asset(
                    _musics[i].icon,
                    width: 50.r,
                    height: 50.r,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<MusicFlavors> get _musics {
    return MusicFlavors.values.where((x) => x != MusicFlavors.none).toList();
  }

  void _musicManagement(BuildContext context, MusicFlavors flavor) {
    if (flavor == selectedMusic) {
      MusicServices.stop();
      onChanged.call(MusicFlavors.none);
    } else {
      MusicServices.play(flavor.url);
      onChanged.call(flavor);
    }
    Navigator.pop(context);
  }
}
