// ignore_for_file: avoid_dynamic_calls

import 'package:equatable/equatable.dart';

class AddressModel extends Equatable {
  const AddressModel({
    required this.placeName,
    required this.latitude,
    required this.longitude,
    required this.placeId,
    required this.placeFormattedAddress,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      placeName: json['address_components'][0]['short_name'] as String,
      latitude: json['geometry']['location']['lat'] as double,
      longitude: json['geometry']['location']['lng'] as double,
      placeId: json['place_id'] as String,
      placeFormattedAddress: json['formatted_address'] as String,
    );
  }

  final String placeName;
  final double latitude;
  final double longitude;
  final String placeId;
  final String placeFormattedAddress;

  @override
  List<Object?> get props => [
        placeName,
        latitude,
        longitude,
        placeId,
        placeFormattedAddress,
      ];
}
