import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/theme/theme_colors.dart';
import 'package:happy_habit/core/theme/typography.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/theme/theme_colors.dart';
import 'package:happy_habit/core/theme/typography.dart';

class CustomDurationPicker extends StatefulWidget {
  final Duration initialDuration;
  final ValueChanged<Duration> onChanged;

  const CustomDurationPicker({
    super.key,
    required this.initialDuration,
    required this.onChanged,
  });

  @override
  State<CustomDurationPicker> createState() => _CustomDurationPickerState();
}

class _CustomDurationPickerState extends State<CustomDurationPicker> {
  late int selectedHours;
  late int selectedMinutes;
  late int selectedSeconds;

  late FixedExtentScrollController hoursController;
  late FixedExtentScrollController minutesController;
  late FixedExtentScrollController secondsController;

  @override
  void initState() {
    super.initState();
    selectedHours = widget.initialDuration.inHours;
    selectedMinutes = widget.initialDuration.inMinutes % 60;
    selectedSeconds = widget.initialDuration.inSeconds % 60;

    hoursController = FixedExtentScrollController(initialItem: selectedHours);
    minutesController = FixedExtentScrollController(initialItem: selectedMinutes);
    secondsController = FixedExtentScrollController(initialItem: selectedSeconds);
  }

  @override
  void dispose() {
    hoursController.dispose();
    minutesController.dispose();
    secondsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Column(
                children: [
                  Divider(color: ThemeColor.graphiteGrey),
                  60.height,
                  Divider(color: ThemeColor.graphiteGrey),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildPicker(
                    controller: hoursController,
                    itemCount: 24,
                    labelBuilder: (index) => index.toString().padLeft(2, '0'),
                    onSelectedItemChanged: (index) => _updateDuration(hours: index),
                    selectedIndex: selectedHours,
                  ),
                  _buildDivider(),
                  _buildPicker(
                    controller: minutesController,
                    itemCount: 60,
                    labelBuilder: (index) => index.toString().padLeft(2, '0'),
                    onSelectedItemChanged: (index) => _updateDuration(minutes: index),
                    selectedIndex: selectedMinutes,
                  ),
                  _buildDivider(),
                  _buildPicker(
                    controller: secondsController,
                    itemCount: 60,
                    labelBuilder: (index) => index.toString().padLeft(2, '0'),
                    onSelectedItemChanged: (index) => _updateDuration(seconds: index),
                    selectedIndex: selectedSeconds,
                  ),
                  Text(
                    ' Sec',
                    style: context.titleMedium,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _updateDuration({int? hours, int? minutes, int? seconds}) {
    setState(() {
      if (hours != null) selectedHours = hours;
      if (minutes != null) selectedMinutes = minutes;
      if (seconds != null) selectedSeconds = seconds;
    });

    final duration = Duration(
      hours: selectedHours,
      minutes: selectedMinutes,
      seconds: selectedSeconds,
    );
    widget.onChanged(duration);
  }

  Widget _buildPicker({
    required FixedExtentScrollController controller,
    required int itemCount,
    required String Function(int) labelBuilder,
    required ValueChanged<int> onSelectedItemChanged,
    required int selectedIndex,
  }) {
    return SizedBox(
      width: 60.w,
      height: 140.h,
      child: ListWheelScrollView.useDelegate(
        controller: controller,
        itemExtent: 60,
        physics: FixedExtentScrollPhysics(),
        onSelectedItemChanged: onSelectedItemChanged,
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: itemCount,
          builder: (context, index) => Center(
            child: Text(
              labelBuilder(index),
              style: context.titleMedium?.copyWith(
                fontWeight: selectedIndex == index ? null : FontWeight.normal,
                color: selectedIndex == index ? null : ThemeColor.graphiteGrey,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        ':',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}


// class CustomDurationPicker extends StatefulWidget {
//   final Duration initialDuration;
//   final ValueChanged<Duration> onChanged;
//
//   const CustomDurationPicker({
//     super.key,
//     required this.onChanged,
//     required this.initialDuration,
//   });
//
//   @override
//   State<CustomDurationPicker> createState() => _CustomDurationPickerState();
// }
//
// class _CustomDurationPickerState extends State<CustomDurationPicker> {
//   // int selectedHours = 0;
//   // int selectedMinutes = 0;
//   // int selectedSeconds = 0;
//
//   late int selectedHours;
//   late int selectedMinutes;
//   late int selectedSeconds;
//
//   @override
//   void initState() {
//     super.initState();
//     selectedHours = widget.initialDuration.inHours;
//     selectedMinutes = widget.initialDuration.inMinutes % 60;
//     selectedSeconds = widget.initialDuration.inSeconds % 60;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Stack(
//           alignment: Alignment.center,
//           children: [
//             Column(
//               children: [
//                 Divider(color: ThemeColor.graphiteGrey),
//                 60.height,
//                 Divider(color: ThemeColor.graphiteGrey),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 _buildPicker(
//                   24,
//                   (index) => index.toString().padLeft(2, '0'),
//                   (index) => _updateDuration(hours: index),
//                   selectedHours,
//                 ),
//                 _buildDivider(),
//                 _buildPicker(
//                   60,
//                   (index) => index.toString().padLeft(2, '0'),
//                   (index) => _updateDuration(minutes: index),
//                   selectedMinutes,
//                 ),
//                 _buildDivider(),
//                 _buildPicker(
//                   60,
//                   (index) => index.toString().padLeft(2, '0'),
//                   (index) => _updateDuration(seconds: index),
//                   selectedSeconds,
//                 ),
//                 Text(
//                   ' Sec',
//                   style: context.titleMedium,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   void _updateDuration({int? hours, int? minutes, int? seconds}) {
//     setState(() {
//       if (hours != null) selectedHours = hours;
//       if (minutes != null) selectedMinutes = minutes;
//       if (seconds != null) selectedSeconds = seconds;
//     });
//
//     final duration = Duration(
//       hours: selectedHours,
//       minutes: selectedMinutes,
//       seconds: selectedSeconds,
//     );
//     widget.onChanged?.call(duration);
//   }
//
//   Widget _buildPicker(
//     int itemCount,
//     String Function(int) labelBuilder,
//     ValueChanged<int> onSelectedItemChanged,
//     int selectedIndex,
//   ) {
//     return SizedBox(
//       width: 60.w,
//       height: 140.h,
//       child: ListWheelScrollView.useDelegate(
//         itemExtent: 60,
//         physics: FixedExtentScrollPhysics(),
//         onSelectedItemChanged: onSelectedItemChanged,
//         childDelegate: ListWheelChildBuilderDelegate(
//           childCount: itemCount,
//           builder: (context, index) => Center(
//             child: Text(
//               labelBuilder(index),
//               style: context.titleMedium?.copyWith(
//                 fontWeight: selectedIndex == index ? null : FontWeight.normal,
//                 color: selectedIndex == index ? null : ThemeColor.graphiteGrey,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDivider() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//       child: Text(
//         ':',
//         style: TextStyle(
//           fontSize: 24,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     );
//   }
// }
