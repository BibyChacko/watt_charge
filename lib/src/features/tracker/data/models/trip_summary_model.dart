import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'trip_summary_model.freezed.dart';


@freezed
class TripSummaryModel with _$TripSummaryModel {
  const factory TripSummaryModel({
    required double distanceCovered,
    required double amount,
    required double timeTakenInMin,
    required double averageTimeInMin,
    required LatLng startLocation,
    required LatLng endLocation,
    required LatLng destination,
  }) = _TripSummaryModel;

}
