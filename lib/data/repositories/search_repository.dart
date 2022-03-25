import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../helpers/request_helper.dart';
import '../models/address_model.dart';
import '../models/direction_details_model.dart';
import '../models/prediction_model.dart';

abstract class SearchRepository {
  Future<AddressModel> getAddress(Position position);
  Future<AddressModel> getAddressByPlaceId(String placeId);
  Future<List<PredictionModel>> fetchByLocationName(String locationName);
  Future<DirectionDetailsModel> fetchDirectionDetails({
    required LatLng startPosition,
    required LatLng endPosition,
  });
}

class SearchRepositoryImpl implements SearchRepository {
  @override
  Future<AddressModel> getAddress(Position position) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.mobile &&
        connectivityResult != ConnectivityResult.wifi) {
      return Future.error('No internet');
    }

    // https://maps.googleapis.com/maps/api/geocode/json?latlng=40.714224,-73.961452&key=YOUR_API_KEY
    final uri = Uri(
      scheme: 'https',
      host: 'maps.googleapis.com',
      path: 'maps/api/geocode/json',
      queryParameters: {
        'latlng': '${position.latitude},${position.longitude}',
        'key': dotenv.env['MAP_KEY'],
      },
    );

    final response = await RequestHelper().getRequest(uri);

    if (response == 'failed') {
      return Future.error('Something went wrong');
    }

    final address =
        AddressModel.fromJson(response['results'][0] as Map<String, dynamic>);

    return Future.value(address);
  }

  @override
  Future<List<PredictionModel>> fetchByLocationName(
    String locationName,
  ) async {
    // https:///maps/api/place/autocomplete/json?input=Time Square&key=YOUR API KEY&sessiontoken=123254251&components=country:us
    final uri = Uri(
        scheme: 'https',
        host: 'maps.googleapis.com',
        path: 'maps/api/place/autocomplete/json',
        queryParameters: {
          'input': locationName,
          'key': dotenv.env['MAP_KEY'],
          'sessiontoken': '123254251',
          'components': 'country:us',
        });

    final response = await RequestHelper().getRequest(uri);

    if (response == 'failed') {
      return Future.error('Something went wrong');
    }

    final predictions = (response['predictions'] as List)
        .map((e) => e as Map<String, dynamic>)
        .toList()
        .map(PredictionModel.fromJson)
        .toList();

    return Future.value(predictions);
  }

  @override
  Future<AddressModel> getAddressByPlaceId(String placeId) async {
    // https: //maps.googleapis.com/maps/api/place/details/json?placeid={place_id}&key=YOUR API KEY
    final uri = Uri(
      scheme: 'https',
      host: 'maps.googleapis.com',
      path: 'maps/api/place/details/json',
      queryParameters: {
        'placeid': placeId,
        'key': dotenv.env['MAP_KEY'],
      },
    );

    final response = await RequestHelper().getRequest(uri);

    if (response == 'failed') {
      return Future.error('Something went wrong');
    }

    final placeDetails =
        AddressModel.fromJson(response['result'] as Map<String, dynamic>);

    return Future.value(placeDetails);
  }

  @override
  Future<DirectionDetailsModel> fetchDirectionDetails({
    required LatLng startPosition,
    required LatLng endPosition,
  }) async {
    // https://maps.googleapis.com/maps/api/directions/json?origin={latitude},{longitude}&destination={latitude},{longitude}&mode=driving&key={your_api_key}

    try {
      final uri = Uri(
        scheme: 'https',
        host: 'maps.googleapis.com',
        path: 'maps/api/directions/json',
        queryParameters: {
          'origin': '${startPosition.latitude},${startPosition.longitude}',
          'destination': '${endPosition.latitude},${endPosition.longitude}',
          'mode': 'driving',
          'key': dotenv.env['MAP_KEY'],
        },
      );

      final response = await RequestHelper().getRequest(uri);

      print(response);
      // {geocoded_waypoints: [{}, {}], routes: [], status: ZERO_RESULTS}

      final direction = DirectionDetailsModel.fromJson(
        response['routes'] as Map<String, dynamic>,
      );

      print(direction.encodePoints);

      return Future.value(direction);
    } catch (e) {
      rethrow;
    }
  }
}
