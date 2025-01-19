import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happy_habit/core/extensions/duration_extensions.dart';
import 'package:happy_habit/core/extensions/string_extensions.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/theme/typography.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../core/theme/theme_colors.dart';
import '../services/activity.dart';

class ProgressTrackingGraph extends StatelessWidget {
  final List<Activity> data;

  const ProgressTrackingGraph({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SfCircularChart(
            series: <CircularSeries>[
              DoughnutSeries<Activity, String>(
                dataSource: data,
                xValueMapper: (Activity activity, _) => activity.title,
                yValueMapper: (Activity activity, _) => activity.duration.inHours.toDouble(),
                pointColorMapper: (Activity activity, _) => activity.color,
                dataLabelSettings: DataLabelSettings(isVisible: true),
              ),
            ],
          ),
          Text(
            'Time Spent in Zone',
            style: context.bodySmall?.copyWith(
              color: ThemeColor.hint,
            ),
          ),
          10.height,
          ...List.generate(
            data.length,
            (i) => Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 0.3.sw,
                  child: Text(
                    data[i].title.capitalize(),
                    style: context.bodyMedium?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(data[i].duration.toFormattedString()),
                Container(
                  height: 15.h,
                  width: 0.3.sw,
                  margin: EdgeInsets.symmetric(vertical: 5.r),
                  decoration: BoxDecoration(
                    color: data[i].color,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}