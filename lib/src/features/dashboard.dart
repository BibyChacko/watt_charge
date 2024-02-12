import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:watt_charge_tracker/src/core/common/widgets/app_button.dart';
import 'package:watt_charge_tracker/src/core/common/widgets/app_textform_field.dart';
import 'package:watt_charge_tracker/src/core/helpers/location_helper.dart';
import 'package:watt_charge_tracker/src/core/validators/form_validators.dart';

import 'place_picker/presentation/view/pages/place_picker_page.dart';
import 'tracker/presentation/controller/tracker_controller.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final TextEditingController _sourceTextEditingController =
      TextEditingController();
  final TextEditingController _destinationTextEditingController =
      TextEditingController();

  final Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(25.276987, 55.296249),
    zoom: 14.4746,
  );

  Set<Marker> locationSet = {};
  LatLng? startLocation;
  LatLng? endLocation;

  var trackerController = Get.find<TrackerController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
                flex: 1,
                child: GoogleMap(
                  markers: locationSet,
                  mapType: MapType.normal,
                  initialCameraPosition: _initialCameraPosition,
                  onMapCreated: (mapController) async {
                    _controller.complete(mapController);
                    if (_controller.isCompleted) {}
                    LatLng? deviceLocation = await Get.find<LocationService>()
                        .getDeviceCurrentLocation();
                    if (deviceLocation != null) {
                      mapController.animateCamera(
                          CameraUpdate.newLatLng(deviceLocation));
                      MarkerId markerId = MarkerId(
                        deviceLocation.hashCode.toString(),
                      );
                      Marker marker = Marker(
                        position: deviceLocation,
                        markerId: markerId,
                        infoWindow: const InfoWindow(title: "Your location"),
                      );
                      locationSet.add(marker);
                      setState(() {});
                    }
                  },
                )),
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    AppTextFormField(
                        label: "Enter source",
                        readOnly: true,
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(
                                  builder: (_) => const PlacePickerPage()))
                              .then((value) {
                            PickResult pickedLocation = value[0];
                            if (pickedLocation.geometry?.location == null) {
                              return;
                            }
                            startLocation = LatLng(
                                pickedLocation.geometry!.location.lat,
                                pickedLocation.geometry!.location.lng);
                            _sourceTextEditingController.text =
                                pickedLocation.formattedAddress ?? "";
                          });
                        },
                        textEditingController: _sourceTextEditingController,
                        validator: (val) => FormValidators.isNullOrEmpty(val)),
                    const SizedBox(
                      height: 16,
                    ),
                    const Row(
                      children: [
                        Flexible(
                            flex: 1,
                            child: Divider(
                              indent: 8,
                              endIndent: 8,
                              color: Colors.grey,
                            )),
                        Text("to"),
                        Flexible(
                            flex: 1,
                            child: Divider(
                              indent: 8,
                              endIndent: 8,
                              color: Colors.grey,
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    AppTextFormField(
                        label: "Enter endLocation",
                        readOnly: true,
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(
                                  builder: (_) => const PlacePickerPage()))
                              .then((value) {
                            PickResult pickedLocation = value[0];
                            if (pickedLocation.geometry?.location == null) {
                              return;
                            }
                            endLocation = LatLng(
                                pickedLocation.geometry!.location.lat,
                                pickedLocation.geometry!.location.lng);
                            _destinationTextEditingController.text =
                                pickedLocation.formattedAddress ?? "";
                          });
                        },
                        textEditingController:
                            _destinationTextEditingController,
                        validator: (val) => FormValidators.isNullOrEmpty(val)),
                    const SizedBox(
                      height: 32,
                    ),
                    AppButton(
                        buttonText: "Let's go",
                        width: MediaQuery.of(context).size.width,
                        onPressed: () {
                          if (startLocation == null || endLocation == null) {
                            return;
                          }
                          trackerController.startTrip(
                              startLocation!, endLocation!);
                        })
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
