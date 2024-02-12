import 'package:flutter/material.dart';
import 'package:google_maps_directions/google_maps_directions.dart';
import 'package:watt_charge_tracker/src/core/credentials/map_credentials.dart';
import 'package:watt_charge_tracker/src/watt_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoogleMapsDirections.init(googleAPIKey: CredentialHelper.getMapsAPIKey());
  runApp(const WattApp());
}
