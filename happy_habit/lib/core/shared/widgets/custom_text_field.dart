import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happy_habit/core/theme/typography.dart';

import '../../theme/theme_colors.dart';
import 'tap_widget.dart';

class CustomTextField extends StatefulWidget {
  final bool obscure;
  final String? hint;
  final bool? readOnly;
  final bool showIcons;
  final VoidCallback? onTap;
  final Widget? prefix, suffix;
  final Color? foregroundColor;
  final int? maxLines, maxLength;
  final InputDescriptor descriptor;
  final TextInputType? keyboardType;
  final bool autofocus, showHintAsTitle;
  final ValueChanged<String>? onChanged;
  final TextInputAction? textInputAction;
  final EdgeInsetsGeometry? contentPadding;
  final Function(String?)? onFieldSubmitted;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextField({
    super.key,
    this.hint,
    this.onTap,
    this.prefix,
    this.suffix,
    this.readOnly,
    this.validator,
    this.maxLength,
    this.onChanged,
    this.keyboardType,
    this.maxLines = 1,
    this.contentPadding,
    this.foregroundColor,
    this.onFieldSubmitted,
    this.autofocus = false,
    required this.descriptor,
    this.showHintAsTitle = false,
    this.textInputAction = TextInputAction.done,
    this.inputFormatters,
  })  : obscure = false,
        showIcons = false;

  const CustomTextField.obscure({
    super.key,
    this.hint,
    this.onTap,
    this.prefix,
    this.readOnly,
    this.validator,
    this.maxLength,
    this.onChanged,
    this.keyboardType,
    this.maxLines = 1,
    this.contentPadding,
    this.foregroundColor,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.autofocus = false,
    this.showIcons = false,
    required this.descriptor,
    this.showHintAsTitle = false,
    this.textInputAction = TextInputAction.done,
  })  : suffix = null,
        obscure = true;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late final ValueNotifier<bool> _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = ValueNotifier<bool>(widget.obscure);
  }

  @override
  void dispose() {
    super.dispose();
    _obscureText.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.showHintAsTitle && widget.hint != null)
          Padding(
            padding: EdgeInsets.only(bottom: 5.h),
            child: Text(
              widget.hint!,
              style: context.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ValueListenableBuilder(
          valueListenable: _obscureText,
          builder: (context, secure, _) => TextFormField(
            onTap: widget.onTap,
            obscureText: secure,
            maxLines: widget.maxLines,
            maxLength: widget.maxLength,
            validator: widget.validator,
            autofocus: widget.autofocus,
            onChanged: widget.onChanged,
            cursorColor: ThemeColor.primary,
            canRequestFocus: _canRequestFocus,
            focusNode: widget.descriptor.focusNode,
            textInputAction: widget.textInputAction,
            controller: widget.descriptor.controller,
            textAlignVertical: TextAlignVertical.top,
            onFieldSubmitted: widget.onFieldSubmitted,
            readOnly: widget.readOnly ?? widget.onTap != null,
            onTapOutside: (event) => widget.descriptor.focusNode.unfocus(),
            style: context.bodyLarge?.copyWith(
              color: widget.descriptor.focusNode.hasFocus ? ThemeColor.primary : null,
            ),
            keyboardType: widget.obscure ? TextInputType.visiblePassword : widget.keyboardType,
            inputFormatters: widget.inputFormatters,
            decoration: InputDecoration(
              hintText: widget.hint,
              prefixIcon: widget.prefix,
              contentPadding: widget.contentPadding,
              suffixIcon: widget.obscure ? _suffixIcon(secure) : widget.suffix,
            ),
          ),
        ),
      ],
    );
  }

  bool get _canRequestFocus {
    if (widget.readOnly ?? false) return false;
    return widget.onTap == null;
  }

  Widget? _suffixIcon(bool secure) {
    return TapWidget(
      radius: 10,
      padding: EdgeInsets.all(10.r),
      onTap: widget.onTap != null ? null : () => _obscureText.value = !_obscureText.value,
      child: !widget.showIcons
          // ? Icon(secure ? Icons.visibility_off_outlined : CupertinoIcons.eye)
          ? Text(secure ? 'show' : 'hide')
          : Icon(
              secure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
              color: ThemeColor.hint,
            ),
    );
  }
}

class InputDescriptor {
  late TextEditingController controller;
  late FocusNode focusNode;

  InputDescriptor({String? initialValue}) {
    controller = TextEditingController(text: initialValue);
    focusNode = FocusNode();
  }

  void clear() {
    controller.clear();
    focusNode.unfocus();
  }

  void dispose() {
    controller.dispose();
    focusNode.dispose();
  }

  void setText(String vl) {
    controller.text = vl;
  }

  String get text => controller.text.trim();
}
