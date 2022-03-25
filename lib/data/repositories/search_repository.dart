import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';

import '../../helpers/request_helper.dart';
import '../models/address_model.dart';
import '../models/direction_details_model.dart';
import '../models/prediction_model.dart';

abstract class SearchRepository {
  Future<AddressModel> getAddress(Position position);
  Future<AddressModel> getAddressByPlaceId(String placeId);
  Future<List<PredictionModel>> fetchByLocationName(String locationName);
  Future<DirectionDetailsModel> fetchDirectionDetails({
    required LatLng start,
    required LatLng end,
  });
}

class SearchRepositoryImpl implements SearchRepository {
  const SearchRepositoryImpl({required this.logger});

  final Logger logger;

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
        // ignore: avoid_dynamic_calls
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
      },
    );

    final response = await RequestHelper().getRequest(uri);

    if (response == 'failed') {
      return Future.error('Something went wrong');
    }

    // ignore: avoid_dynamic_calls
    final predictions = (response['predictions'] as List)
        .map((e) => e as Map<String, dynamic>)
        .toList()
        .map(PredictionModel.fromJson)
        .toList();

    return Future.value(predictions);
  }

  @override
  Future<AddressModel> getAddressByPlaceId(String placeId) async {
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
        // ignore: avoid_dynamic_calls
        AddressModel.fromJson(response['result'] as Map<String, dynamic>);

    return Future.value(placeDetails);
  }

  @override
  Future<DirectionDetailsModel> fetchDirectionDetails({
    required LatLng start,
    required LatLng end,
  }) async {
    try {
      final uri = Uri(
        scheme: 'https',
        host: 'maps.googleapis.com',
        path: 'maps/api/directions/json',
        queryParameters: {
          'origin': '${start.latitude},${start.longitude}',
          'destination': '${end.latitude},${end.longitude}',
          'mode': 'driving',
          'key': dotenv.env['MAP_KEY'],
        },
      );

      final response = await RequestHelper().getRequest(uri);

      logger.d(response);
      // {geocoded_waypoints: [{}, {}], routes: [], status: ZERO_RESULTS}

      final direction = DirectionDetailsModel.fromJson(
        // ignore: avoid_dynamic_calls
        response['routes'] as Map<String, dynamic>,
      );

      logger.d(direction.encodePoints);

      return Future.value(direction);
    } catch (e) {
      rethrow;
    }
  }
}
