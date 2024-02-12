
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:watt_charge_tracker/src/core/common/widgets/app_button.dart';
import 'package:watt_charge_tracker/src/core/theme/app_theme.dart';
import 'package:watt_charge_tracker/src/features/tracker/presentation/controller/tracker_controller.dart';

class TrackerPage extends StatefulWidget {
  const TrackerPage(
      {super.key, required this.startLocation, required this.endLocation});
  final LatLng startLocation;
  final LatLng endLocation;

  @override
  State<TrackerPage> createState() => _TrackerPageState();
}

class _TrackerPageState extends State<TrackerPage> {
  late LatLng currentLocation;

  var trackerController = Get.find<TrackerController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Card(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppButton(
                          buttonText: "Cancel trip",
                          backgroundColor: Colors.white,
                          foregroundColor: AppTheme.primaryColor,
                          onPressed: () {
                            trackerController.cancelTrip();
                          }),
                      AppButton(
                          buttonText: "Finish trip",
                          onPressed: () {
                            trackerController.endTrip();
                          }),
                      Text(
                          "${trackerController.currentLocation.value.latitude} , ${trackerController.currentLocation.value.latitude}")
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Obx(() =>
                                Text(trackerController.tripDistance.value)),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Obx(() => Text(trackerController.tripDuration.value)),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        body: Obx(
          () => GoogleMap(
            initialCameraPosition: CameraPosition(
                target: trackerController.currentLocation.value, zoom: 15.0),
            mapType: MapType.normal,
            polylines: Set.from(trackerController.polyLines.toList()),
            onMapCreated: (mapController) {
              trackerController.mapController.complete(mapController);
              trackerController
                  .listenForLocationChanges(); // Tracking happens here
            },
            markers: {
              Marker(
                  markerId: const MarkerId('currentLocation'),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueMagenta),
                  position: trackerController.currentLocation.value),
              Marker(
                  markerId: const MarkerId('startLocation'),
                  position: trackerController.startLocation),
              Marker(
                  markerId: const MarkerId('destinationLocation'),
                  position: widget.endLocation),
            },
          ),
        ));
  }
}
