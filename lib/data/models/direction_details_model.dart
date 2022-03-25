// ignore_for_file: avoid_dynamic_calls

import 'package:equatable/equatable.dart';

class DirectionDetailsModel extends Equatable {
  const DirectionDetailsModel({
    required this.distanceText,
    required this.distanceValue,
    required this.durationText,
    required this.durationValue,
    required this.encodePoints,
  });

  factory DirectionDetailsModel.fromJson(Map<String, dynamic> json) {
    return DirectionDetailsModel(
      distanceText: json[0]['legs'][0]['distance']['text'] as String,
      distanceValue: json[0]['legs'][0]['distance']['value'] as int,
      durationText: json[0]['legs'][0]['duration']['text'] as String,
      durationValue: json[0]['legs'][0]['duration']['value'] as int,
      encodePoints: json[0]['overview_polyline']['points'] as String,
    );
  }

  final String distanceText;
  final int distanceValue;
  final String durationText;
  final int durationValue;
  final String encodePoints;

  @override
  List<Object?> get props => [
        distanceText,
        distanceValue,
        durationText,
        durationValue,
        encodePoints,
      ];
}
