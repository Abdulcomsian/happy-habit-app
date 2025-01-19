import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:happy_habit/core/constants/asset_paths.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/theme/theme_colors.dart';
import 'package:happy_habit/core/theme/typography.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class StreakCalendar extends StatefulWidget {
  final DateTime startDate;
  final DateTime endDate;

  const StreakCalendar({
    super.key,
    required this.startDate,
    required this.endDate,
  });

  @override
  State<StreakCalendar> createState() => _StreakCalendarState();
}

class _StreakCalendarState extends State<StreakCalendar> {
  Color? previousColor;
  Color nextColor = Color(0xFFFFDA58);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: Stack(
        children: [
          SfDateRangePicker(
            enablePastDates: true,
            selectionMode: DateRangePickerSelectionMode.range,
            initialSelectedRange: PickerDateRange(widget.startDate, widget.endDate),
            // onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
            //   // Handle selection change if needed
            // },
            monthViewSettings: DateRangePickerMonthViewSettings(
              dayFormat: 'EEE',
            ),
            backgroundColor: Colors.white,
            headerStyle: DateRangePickerHeaderStyle(
              textAlign: TextAlign.center,
              backgroundColor: Colors.white,
              textStyle: context.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            headerHeight: 60.h,

            monthCellStyle: DateRangePickerMonthCellStyle(
              textStyle: context.bodySmall,
              weekendTextStyle: context.bodySmall?.copyWith(
                color: ThemeColor.primary,
              ),
            ),
            rangeSelectionColor: Colors.transparent,
            endRangeSelectionColor: Colors.transparent,
            startRangeSelectionColor: Colors.transparent,
            cellBuilder: (context, details) {
              DateTime nextDate = details.date.add(Duration(days: 1)); // Next day

              bool isWithinRange =
                  details.date.isAfter(widget.startDate.subtract(Duration(days: 1))) &&
                      details.date.isBefore(widget.endDate.add(Duration(days: 1)));

              // Calculate gradient based on the date's position in the range
              Color startColor = Color(0xFFFFDA58); // Yellow
              Color endColor = Color(0xFFFF924D); // Primary
              // Color endColor = Color(0xFFFFDA58); // Yellow
              // Color startColor = Color(0xFFFF924D); // Primary

              if (isWithinRange) {
                double progress = details.date.difference(widget.startDate).inDays /
                    widget.endDate.difference(widget.startDate).inDays;

                double nextProgress = nextDate.difference(widget.startDate).inDays /
                    widget.endDate.difference(widget.startDate).inDays;
                Color currentColor = Color.lerp(startColor, endColor, progress)!;
                nextColor = Color.lerp(startColor, endColor, nextProgress)!;
                previousColor ??= currentColor;

                List<Color> gradientColorsV2 = [previousColor!, currentColor, nextColor];
                previousColor = currentColor;

                return Container(
                  height: 40,
                  alignment: Alignment.center,
                  // padding: EdgeInsets.symmetric(vertical: 3),
                  margin: EdgeInsets.only(
                    bottom: 3,
                    left: details.date.weekday == DateTime.sunday ? 10 : 0,
                    right: details.date.weekday == DateTime.saturday ? 10 : 0,
                  ),
                  //_getMargin(details.date),
                  decoration: BoxDecoration(
                    color: currentColor, // Set the dynamically calculated color
                    borderRadius: _getBorderRadius(details.date),
                    gradient: LinearGradient(
                      colors: gradientColorsV2,
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  width: double.infinity,
                  child: details.date != widget.endDate
                      ? Text(
                          details.date.day.toString(),
                          style: context.bodySmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              details.date.day.toString(),
                              style: context.bodySmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            3.width,
                            SvgPicture.asset(
                              AppIcons.fire,
                              width: 16.r,
                              height: 16.r,
                            )
                          ],
                        ),
                );
              }

              // Default cell for dates outside the range
              return Center(
                child: Text(
                  '${details.date.day}',
                  style: context.bodySmall,
                ),
              );
            },
          ),
          Positioned.fill(
            top: 60.h,
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }

  bool isBoundary(DateTime date) {
    return date.isAtSameMomentAs(widget.startDate) || date.isAtSameMomentAs(widget.endDate);
  }

  // Function to return the border radius based on whether the date is the start or end date
  BorderRadius _getBorderRadius(DateTime date) {
    if (date.isAtSameMomentAs(widget.startDate)) {
      return BorderRadius.horizontal(
        left: Radius.circular(50), // Rounded on the left side for the start date
        // right: Radius.circular(0), // No rounding on the right side
      );
    } else if (date.isAtSameMomentAs(widget.endDate)) {
      return BorderRadius.horizontal(
        // left: Radius.circular(0), // No rounding on the left side
        right: Radius.circular(50), // Rounded on the right side for the end date
      );
    } else if (date.weekday == DateTime.sunday) {
      return BorderRadius.horizontal(
        left: Radius.circular(50),
      );
    } else if (date.weekday == DateTime.saturday) {
      return BorderRadius.horizontal(
        right: Radius.circular(50),
      );
    }
    return BorderRadius.zero; // No rounding for dates in between
  }
}
