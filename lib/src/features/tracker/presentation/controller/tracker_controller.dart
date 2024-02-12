import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_directions/google_maps_directions.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:watt_charge_tracker/src/core/helpers/dialog_helper.dart';
import 'package:watt_charge_tracker/src/core/helpers/location_helper.dart';
import 'package:watt_charge_tracker/src/features/tracker/data/models/trip_summary_model.dart';
import 'package:watt_charge_tracker/src/features/tracker/domain/tracker_repository.dart';
import 'package:watt_charge_tracker/src/features/tracker/presentation/view/pages/tracker_page.dart';
import 'package:watt_charge_tracker/src/features/tracker/presentation/view/pages/trip_summary_page.dart';
import 'package:watt_charge_tracker/src/features/tracker/presentation/view/widgets/cancel_fail_widget.dart';
import 'package:watt_charge_tracker/src/features/tracker/presentation/view/widgets/cancel_trip_widget.dart';
import 'package:watt_charge_tracker/src/features/tracker/presentation/view/widgets/trip_complete_widget.dart';

enum TrackingState {
  idle,
  planning,
  running,
  reached,
  cancelled,
  calculating,
  summary
}

class TrackerController extends GetxController implements TrackerRepository {
  var currentLocation = const LatLng(0, 0).obs;
  var endLocation = const LatLng(0, 0);
  var startLocation = const LatLng(0, 0);
  var tripDuration = "--".obs;
  var tripDistance = "--".obs;
  var polyLines = [].obs;
  var trackingStatus = TrackingState.idle.obs;
  final Stopwatch _tripTimer = Stopwatch();

  final int _ratePerKm = 2;
  final Completer<GoogleMapController> mapController = Completer();
  late GoogleMapController googleMapController;

  var locationService = Get.find<LocationService>();

  clearTrip() {
    trackingStatus.value = TrackingState.idle;
    polyLines.value = [];
    tripDuration.value = "--";
    tripDistance.value = "--";
    startLocation = const LatLng(0, 0);
    endLocation = const LatLng(0, 0);
    googleMapController.dispose();
    _tripTimer.stop();
    _tripTimer.reset();
  }

  @override
  void onInit() {
    initiateMapController();
    super.onInit();
  }

  Future<void> initiateMapController() async {
    googleMapController = await mapController.future;
  }

  @override
  startTrip(LatLng startLocation, LatLng endLocation) async {
    trackingStatus.value = TrackingState.planning;

    this.startLocation = startLocation;
    this.endLocation = endLocation;

    await updateCurrentLocation(startLocation);
    trackingStatus.value = TrackingState.running;

    _tripTimer.start();
    Get.to(TrackerPage(startLocation: startLocation, endLocation: endLocation));
  }

  @override
  cancelTrip() {
    _tripTimer.stop();
    int tripDuration = _tripTimer.elapsed.inMinutes;
    if (tripDuration > 3) {
      // Trip can`t be cancelled after 3 min,end trip instead and pay fare.
      DialogHelper.showDialog(
          title: "Cancel trip?",
          content: CancelFailWidget(onEndTrip: () {
            endTrip();
          }, onContinueTrip: () {
            Get.back();
          }));
      endTrip();
      return;
    } else {
      trackingStatus.value = TrackingState.cancelled;
      DialogHelper.showDialog(
          title: "Cancel trip?",
          content: CancelTripWidget(onCancelTrip: () {
            locationService.cancelLocationSubscription();
            clearTrip();
            Get.back();
            Get.back();
          }, onContinueTrip: () {
            Get.back();
          }));
    }
  }

  @override
  endTrip() async {
    DialogHelper.showDialog(
        title: "Trip Completed",
        content: TripCompleteWidget(onProceed: () {
          Get.back();
        }));
    await Future.delayed(const Duration(seconds: 3));
    locationService.cancelLocationSubscription();
    _tripTimer.stop();
    trackingStatus.value = TrackingState.reached;
    calculateFair();
  }

  listenForLocationChanges() {
    locationService.listenLocationStream()?.listen((event) {
      LatLng updatedLocation = LatLng(event.latitude, event.longitude);
      googleMapController
          .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        zoom: 30,
        target: LatLng(
          updatedLocation.latitude,
          updatedLocation.longitude,
        ),
      )));
      updateCurrentLocation(updatedLocation);
      checkIfDestinationReached(updatedLocation);
    });
  }

  updateCurrentLocation(LatLng updatedLocation) async {
    currentLocation.value =
        LatLng(updatedLocation.latitude, updatedLocation.longitude);
    await getDurationLeft(updatedLocation, endLocation);
    await getDistanceLeft(updatedLocation, endLocation);
    await getPlottingLines(updatedLocation, endLocation);
  }

  checkIfDestinationReached(LatLng updatedLocation) {
    bool reached =
        locationService.hasReachedDestination(updatedLocation, endLocation);
    if (!reached) return;
    endTrip();
  }

  Future<void> getDurationLeft(LatLng startLocation, LatLng endLocation) async {
    try{
      DurationValue durationBetween = await duration(startLocation.latitude,
          startLocation.longitude, endLocation.latitude, endLocation.longitude);
      String durationInMinutesOrHours = durationBetween.text;
      tripDuration.value = durationInMinutesOrHours;
    }catch(ex){
      if (kDebugMode) {
        print(ex);
      }
    }

  }

  Future<void> getDistanceLeft(LatLng startLocation, LatLng endLocation) async {
    try{
      DistanceValue distanceBetween = await distance(startLocation.latitude,
          startLocation.longitude, endLocation.latitude, endLocation.longitude);
      String distanceInKmOrMeters = distanceBetween.text;
      tripDistance.value = distanceInKmOrMeters;
    }catch(ex){
      if (kDebugMode) {
        print(ex);
      }
    }

  }

  getPlottingLines(LatLng startLocation, LatLng endLocation) async {
    Directions directions = await getDirections(
      startLocation.latitude,
      startLocation.longitude,
      endLocation.latitude,
      endLocation.longitude,
      language: "en_US",
    );

    DirectionRoute route = directions.shortestRoute;
    List<LatLng> points = PolylinePoints()
        .decodePolyline(route.overviewPolyline.points)
        .map((point) => LatLng(point.latitude, point.longitude))
        .toList();

    polyLines.value = [
      Polyline(
        width: 5,
        polylineId: PolylineId(route.hashCode.toString()),
        color: Colors.green,
        points: points,
      ),
    ];
  }

  Future<double> calculateTotalDistanceInKm() async {
    DistanceValue distanceBetween = await distance(startLocation.latitude,
        startLocation.longitude, endLocation.latitude, endLocation.longitude);
    return distanceBetween.meters / 1000;
  }

  calculateDurationInMin() async {
    DurationValue durationBetween = await duration(startLocation.latitude,
        startLocation.longitude, endLocation.latitude, endLocation.longitude);
    return durationBetween.seconds / 60;
  }

  Future<void> calculateFair() async {
    double distance = await calculateTotalDistanceInKm();
    double totalFair = distance * _ratePerKm;
    double averageTimeInMin = await calculateDurationInMin();
    TripSummaryModel tripSummary = TripSummaryModel(
        distanceCovered: distance,
        amount: totalFair,
        timeTakenInMin: _tripTimer.elapsed.inMinutes.toDouble(),
        averageTimeInMin: averageTimeInMin,
        startLocation: startLocation,
        endLocation: endLocation,
        destination: currentLocation.value);
    showSummaryPage(tripSummary);
  }

  void showSummaryPage(TripSummaryModel tripSummary) {
    Get.to(TripSummaryPage(tripSummaryModel: tripSummary));
    clearTrip();
  }
}
