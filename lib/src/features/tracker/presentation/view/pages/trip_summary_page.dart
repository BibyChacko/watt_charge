import 'package:flutter/material.dart';
import 'package:watt_charge_tracker/src/core/common/widgets/app_button.dart';
import 'package:watt_charge_tracker/src/core/theme/text_theme.dart';
import 'package:watt_charge_tracker/src/features/dashboard.dart';
import 'package:watt_charge_tracker/src/features/tracker/data/models/trip_summary_model.dart';

class TripSummaryPage extends StatelessWidget {
  final TripSummaryModel tripSummaryModel;
  const TripSummaryPage({super.key, required this.tripSummaryModel});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (result) {
        if (!result) {

        }
        return;
      },
      child: Scaffold(
        body: SafeArea(
            child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.grey.withOpacity(.8)),
                    child: const Center(
                        child: Icon(
                      Icons.done,
                      size: 24,
                    ))),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Trip Ended",
                  style: AppTextTheme.heading5,
                ),
                const SizedBox(
                  height: 24,
                ),
                Center(
                  child: Table(
                    children: [
                      TableRow(children: [
                        const Text("Trip Amount"),
                        Text("${tripSummaryModel.amount} AED"),
                      ]),
                      TableRow(children: [
                        const Text("Time Taken"),
                        Text("${tripSummaryModel.timeTakenInMin} min"),
                      ]),
                      TableRow(children: [
                        const Text("Avg. Time"),
                        Text("${tripSummaryModel.averageTimeInMin} min"),
                      ]),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                AppButton(
                    buttonText: "Back to home",
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    })
              ],
            ),
          ),
        )),
      ),
    );
  }
}
