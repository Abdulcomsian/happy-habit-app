import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happy_habit/core/extensions/duration_extensions.dart';
import 'package:happy_habit/core/extensions/int_extensions.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/shared/widgets/custom_network_image.dart';
import 'package:happy_habit/core/shared/widgets/root_screen.dart';
import 'package:happy_habit/core/theme/theme_colors.dart';
import 'package:happy_habit/core/theme/typography.dart';
import 'package:happy_habit/modules/profile_setup/services/goal.dart';
import 'package:happy_habit/modules/profile_setup/services/profile_setup_provider.dart';
import 'package:happy_habit/modules/progress/shared/progress_tracking_graph.dart';
import 'package:provider/provider.dart';

class ProgressTrackingScreen extends StatefulWidget {
  static const id = 'ProgressTrackingScreen';

  const ProgressTrackingScreen({super.key});

  @override
  State<ProgressTrackingScreen> createState() => _ProgressTrackingScreenState();
}

class _ProgressTrackingScreenState extends State<ProgressTrackingScreen> {
  @override
  Widget build(BuildContext context) {
    return RootScreen(
      hideHeader: true,
      crossAxisAlignment: CrossAxisAlignment.start,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        children: [
          Text(
            'Focus Activities',
            style: context.titleMedium?.copyWith(
              color: ThemeColor.hint,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Graph Summary',
            style: context.bodyMedium?.copyWith(
              color: ThemeColor.hint,
              fontWeight: FontWeight.w500,
            ),
          ),
          15.height,
          Text(
            'Today’s Stats',
            style: context.bodyLarge?.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          20.height,
          Consumer<ProfileSetupProvider>(
            builder: (context, prov, _) {
              return GridView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: prov.goals.length,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 11.r,
                  crossAxisSpacing: 11.r,
                  childAspectRatio: 162.w / 100.h,
                ),
                itemBuilder: (context, i) => StatsTile(
                  goal: prov.goals[i],
                ),
              );
            }
          ),
          20.height,
          Text(
            'Focused time',
            style: context.titleMedium?.copyWith(
              color: ThemeColor.hint,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Nov20 - Nov 26, 2024',
                style: context.bodyLarge?.copyWith(
                  color: ThemeColor.hint,
                  fontWeight: FontWeight.w600,
                ),
              ),
              10.width,
              Transform.rotate(
                angle: 90.degree,
                child: Icon(
                  CupertinoIcons.forward,
                  color: ThemeColor.hint,
                ),
              ),
            ],
          ),
          15.height,
          Consumer<ProfileSetupProvider>(
              builder: (context, prov, _) {
              return ProgressTrackingGraph(
                data: prov.goals,
              );
            }
          ),
          40.height,
        ],
      ),
    );
  }
}

class StatsTile extends StatelessWidget {
  final Goal goal;

  const StatsTile({
    super.key,
    required this.goal,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: goal.color,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            goal.title,
            style: context.bodyLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomNetworkImage(
                url: goal.image,
                width: 50.r,
                height: 50.r,
              ),
              15.width,
              Text(
                goal.time.toFormattedString(),
                style: context.bodyLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
