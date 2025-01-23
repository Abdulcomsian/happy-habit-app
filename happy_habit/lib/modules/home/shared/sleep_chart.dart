import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/theme/typography.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SleepChart extends StatelessWidget {
  const SleepChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 420.h,
      width: 0.9.sw,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        children: [
          12.height,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 28.w),
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                  child: Text(
                    'Average Sleep Time',
                    style: context.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                15.height,
                Text(
                  '$_avgHours Hour',
                  style: context.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: SfCartesianChart(
              // title: ChartTitle(text: 'Average Sleep Time'),
              tooltipBehavior: TooltipBehavior(enable: true),
              primaryXAxis: NumericAxis(
                title: AxisTitle(text: 'Days'),
                edgeLabelPlacement: EdgeLabelPlacement.shift,
                axisLine: AxisLine(width: 0),
              ),
              primaryYAxis: NumericAxis(
                title: AxisTitle(text: 'Hours'),
                minimum: 0,
                maximum: 12,
                interval: 2,
                axisLine: AxisLine(width: 0),
              ),
              series: <CartesianSeries>[
                // Lower gradient
                AreaSeries<SleepData, double>(
                  dataSource: getSleepData(),
                  xValueMapper: (SleepData data, _) => data.day,
                  yValueMapper: (SleepData data, _) => data.hours,
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFE0B2), Color(0xFFFFA726)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  opacity: 0.7,
                  name: 'Sleep',
                ),
                // Upper gradient (optional; remove if redundant)
                AreaSeries<SleepData, double>(
                  dataSource: getSleepData(),
                  xValueMapper: (SleepData data, _) => data.day,
                  yValueMapper: (SleepData data, _) => data.hours,
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFCC80), Color(0xFFFF8A65)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  opacity: 0.5,
                  name: 'Avg Sleep',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Dummy data
  List<SleepData> getSleepData() {
    return [
      SleepData(1, 7),
      SleepData(2, 6),
      SleepData(3, 7.5),
      SleepData(4, 5),
      SleepData(5, 8),
      SleepData(6, 6.5),
      SleepData(7, 7),
    ];
  }


  // Getter to calculate average hours and round it to 1 decimal place
  double get _avgHours {
    List<SleepData> data = getSleepData();
    double totalHours = 0;

    for (var sleep in data) {
      totalHours += sleep.hours;
    }

    double average = totalHours / data.length;

    return double.parse(average.toStringAsFixed(1)); // Round to 1 decimal place
  }
}

class SleepData {
  final double day;
  final double hours;

  SleepData(this.day, this.hours);
}
