import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/shared/widgets/tap_widget.dart';
import 'package:happy_habit/core/theme/theme_colors.dart';
import 'package:happy_habit/core/theme/typography.dart';

import '../../../core/shared/widgets/custom_button.dart';

class ActivitySelectionDialog extends StatelessWidget {
  final String selectedActivity;
  late final ValueNotifier _selectedActivity;

  ActivitySelectionDialog({super.key, required this.selectedActivity}) {
    _selectedActivity = ValueNotifier(selectedActivity);
  }

  final List<String> _activities = [
    'meditation',
    'read',
    'study',
    'workout',
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w),

      title: Text(
        'Add Your Focus Timer',
        textAlign: TextAlign.center,
        style: DialogTheme.of(context).titleTextStyle?.copyWith(
              color: ThemeColor.primary,
            ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: TextEditingController(),
            style: context.bodyMedium?.copyWith(
              color: ThemeColor.primary,
            ),
            onTapOutside: (event) => FocusScope.of(context).unfocus(),
            decoration: InputDecoration(
              hintText: 'Title here',
              hintStyle: context.bodyMedium?.copyWith(
                color: ThemeColor.primary,
              ),
              border: _border,
              focusedBorder: _border,
              enabledBorder: _border,
            ),
          ),
          15.height,
          Text(
            'Select an animation type',
            style: context.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          17.height,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Center(
              child: Wrap(
                spacing: 12.r,
                runSpacing: 12.r,
                alignment: WrapAlignment.center,
                children: List.generate(
                  _activities.length,
                  (i) => TapWidget(
                    onTap: () => _selectedActivity.value = _activities[i],
                    child: ValueListenableBuilder(
                      valueListenable: _selectedActivity,
                      builder: (context, act, _) {
                        return Container(
                          width: 80.r,
                          height: 80.r,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(
                              color: _activities[i] == act ? ThemeColor.primary : ThemeColor.border,
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/${_activities[i]}.svg',
                                width: 40.r,
                                height: 40.r,
                              ),
                              5.height,
                              Text(
                                _activities[i],
                                style: context.bodySmall?.copyWith(
                                  color: _activities[i] == act ? ThemeColor.primary : null,
                                  fontWeight: _activities[i] == act ? FontWeight.w600 : FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          27.height,
          Row(
            children: [
              Flexible(
                child: CustomButton(
                  color: ThemeColor.border,
                  label: 'Cancel',
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              10.width,
              Flexible(
                child: CustomButton(
                  label: 'Submit',
                  onPressed: () => Navigator.pop(context, _selectedActivity.value),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  OutlineInputBorder get _border => OutlineInputBorder(
        borderSide: BorderSide(
          color: ThemeColor.primary,
        ),
        borderRadius: BorderRadius.circular(10.r),
      );
}
