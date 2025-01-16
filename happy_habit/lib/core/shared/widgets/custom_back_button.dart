import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happy_habit/core/shared/widgets/tap_widget.dart';

class CustomBackButton extends StatelessWidget {

  final Color? color;
  final VoidCallback? onPressed;

  const CustomBackButton({
    super.key,
    this.onPressed,
    this.color = CupertinoColors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TapWidget(
        radius: 7,
        padding: EdgeInsets.all(7.r),
        onTap: onPressed ?? Navigator.of(context).maybePop,
        color: color?.withValues(alpha: 0.17),
        child: Icon(CupertinoIcons.back, color: color),
      ),
    );
  }
}
