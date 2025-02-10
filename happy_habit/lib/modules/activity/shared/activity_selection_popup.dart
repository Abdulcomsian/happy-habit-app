import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:happy_habit/core/extensions/string_extensions.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/services/validators.dart';
import 'package:happy_habit/core/shared/widgets/tap_widget.dart';
import 'package:happy_habit/core/theme/theme_colors.dart';
import 'package:happy_habit/core/theme/typography.dart';

import '../../../core/shared/widgets/custom_button.dart';

class ActivitySelectionPopup extends StatefulWidget {

  const ActivitySelectionPopup({super.key});

  @override
  State<ActivitySelectionPopup> createState() => _ActivitySelectionPopupState();
}

class _ActivitySelectionPopupState extends State<ActivitySelectionPopup> {
  late final ValueNotifier _selectedMode;
  final _controller = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _validateMode = AutovalidateMode.disabled;

  final List<String> _modes = [
    'meditation',
    'read',
    'study',
    'workout',
  ];

  @override
  void initState() {
    super.initState();
    _selectedMode = ValueNotifier(_modes.first);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
          Form(
            key: _formKey,
            autovalidateMode: _validateMode,
            child: TextFormField(
              controller: _controller,
              style: context.bodyMedium?.copyWith(
                color: ThemeColor.primary,
              ),
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              validator: (value) => Validators.emptyValidationCheck(value, message: 'Enter title'),
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
                  _modes.length,
                  (i) => TapWidget(
                    onTap: () => _selectedMode.value = _modes[i],
                    child: ValueListenableBuilder(
                      valueListenable: _selectedMode,
                      builder: (context, act, _) {
                        return Container(
                          width: 80.r,
                          height: 80.r,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(
                              color: _modes[i] == act ? ThemeColor.primary : ThemeColor.border,
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/${_modes[i]}.svg',
                                width: 40.r,
                                height: 40.r,
                              ),
                              5.height,
                              Text(
                                _modes[i].capitalize(),
                                style: context.bodySmall?.copyWith(
                                  color: _modes[i] == act ? ThemeColor.primary : null,
                                  fontWeight: _modes[i] == act ? FontWeight.w600 : FontWeight.w500,
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
                  onPressed: () => _submit(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _submit(BuildContext context) {
    if(!_formKey.currentState!.validate()){
      setState(() => _validateMode = AutovalidateMode.onUserInteraction);
      return;
    }

    Navigator.pop(context, _selectedMode.value);
    // Navigator.pop(context, _controller.text.trim());
  }

  OutlineInputBorder get _border => OutlineInputBorder(
        borderSide: BorderSide(
          color: ThemeColor.primary,
        ),
        borderRadius: BorderRadius.circular(10.r),
      );
}
