import 'package:flutter/material.dart';
import 'package:watt_charge_tracker/src/core/theme/app_theme.dart';
import 'package:watt_charge_tracker/src/core/theme/text_theme.dart';

import '../../constants/app_dimensions.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    Key? key,
    required this.label,
    required this.textEditingController,
    this.hint,
    this.isObscure = false,
    this.suffix,
    this.validator,
    this.readOnly = false,
    this.onTap,
  }) : super(key: key);

  final String label;
  final String? hint;
  final TextEditingController textEditingController;
  final bool isObscure;
  final bool readOnly;
  final Widget? suffix;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: textEditingController,
        validator: validator,
        readOnly: readOnly,
        onTap: onTap,
        decoration: InputDecoration(
          labelText: label,
            labelStyle: AppTextTheme.bodyLightStyle,
            suffix: suffix,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            hintStyle: AppTextTheme.bodyLightStyle
                .copyWith(color: AppTheme.textColorSecondary, fontSize: 14),
            border: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: AppTheme.textColorPrimary),
                borderRadius: BorderRadius.circular(appBorderRadius)),
            enabledBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: AppTheme.textColorPrimary),
                borderRadius: BorderRadius.circular(appBorderRadius)),
            hintText: hint,
            hintMaxLines: 2,
            floatingLabelBehavior: FloatingLabelBehavior.never),
        obscureText: isObscure);
  }
}
