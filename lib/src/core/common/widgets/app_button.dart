import 'package:flutter/material.dart';
import 'package:watt_charge_tracker/src/core/constants/app_dimensions.dart';
import 'package:watt_charge_tracker/src/core/theme/app_theme.dart';
import 'package:watt_charge_tracker/src/core/theme/text_theme.dart';

class AppButton extends StatelessWidget {
  const AppButton(
      {Key? key,
        required this.buttonText,
        required this.onPressed,
        this.width = 220,
        this.height = 40,
        this.isDisabled = false,
        this.backgroundColor,
        this.foregroundColor})
      : super(key: key);

  final String buttonText;
  final Function onPressed;
  final bool isDisabled;
  final double width;
  final double height;
  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? AppTheme.primaryColor,
            foregroundColor: foregroundColor ?? Colors.white,
            minimumSize: Size(width, height),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(appBorderRadius)),
            textStyle: AppTextTheme.bodyStyle.copyWith(color: Colors.white)),
        onPressed: () {
          isDisabled ? null : onPressed();
        },
        child: Text(buttonText));
  }
}