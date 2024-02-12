import 'package:flutter/material.dart';
import 'package:watt_charge_tracker/src/core/common/widgets/app_button.dart';
import 'package:watt_charge_tracker/src/core/theme/text_theme.dart';

class TripCompleteWidget extends StatelessWidget {
  final VoidCallback onProceed;
  const TripCompleteWidget({super.key, required this.onProceed});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "You have completed he trip",
          style: AppTextTheme.bodySmallStyle,
        ),
        AppButton(
            width: 80,
            buttonText: "Ok, Proceed",
            onPressed: () {
              onProceed();
            }),
      ],
    );
  }
}
