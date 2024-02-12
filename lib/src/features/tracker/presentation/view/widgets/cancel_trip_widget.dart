import 'package:flutter/material.dart';
import 'package:watt_charge_tracker/src/core/common/widgets/app_button.dart';
import 'package:watt_charge_tracker/src/core/theme/text_theme.dart';

class CancelTripWidget extends StatelessWidget {
  final VoidCallback onCancelTrip;
  final VoidCallback onContinueTrip;
  const CancelTripWidget(
      {super.key, required this.onCancelTrip, required this.onContinueTrip});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "You can cancel this trip without any cost",
          style: AppTextTheme.bodyStyle,
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            AppButton(
                width: 60,
                buttonText: "Cancel ",
                onPressed: () {
                  onCancelTrip();
                }),
            const SizedBox(
              width: 12,
            ),
            AppButton(
                width: 60,
                buttonText: "Continue",
                onPressed: () {
                  onContinueTrip();
                })
          ],
        )
      ],
    );
  }
}
