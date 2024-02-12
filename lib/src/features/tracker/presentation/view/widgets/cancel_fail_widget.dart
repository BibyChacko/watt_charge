import 'package:flutter/material.dart';
import 'package:watt_charge_tracker/src/core/common/widgets/app_button.dart';
import 'package:watt_charge_tracker/src/core/theme/text_theme.dart';

class CancelFailWidget extends StatelessWidget {
  final VoidCallback onEndTrip;
  final VoidCallback onContinueTrip;
  const CancelFailWidget({super.key, required this.onEndTrip, required this.onContinueTrip});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Trip can't be cancelled as you have already covered 3 minutes in the trip, you can either end trip or continue",
          style: AppTextTheme.bodySmallStyle,
        ),
        const SizedBox(
          height: 6,
        ),
        Text(
          "Note: Ending the trip will cost you for the distance covered so far",
          style: AppTextTheme.bodySmallExtraLightStyle,
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            AppButton(
                width: 80,
                buttonText: "End Trip",
                onPressed: () {
                  onEndTrip();
                }),
            const SizedBox(width: 12,),
            AppButton(
              width: 80,
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
