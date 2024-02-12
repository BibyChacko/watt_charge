import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:watt_charge_tracker/src/core/credentials/map_credentials.dart';

class PlacePickerPage extends StatefulWidget {
  const PlacePickerPage({super.key});

  @override
  State<PlacePickerPage> createState() => _PlacePickerPageState();
}

class _PlacePickerPageState extends State<PlacePickerPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PlacePicker(
          apiKey: CredentialHelper.getMapsAPIKey(),
          initialPosition: const LatLng(25.276987, 55.296249),
          onPlacePicked: (pickResult) {
            Navigator.pop(context, [pickResult]);
          },
        ),
      ),
    );
  }
}
