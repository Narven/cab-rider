import 'package:cab_rider/constants.dart';
import 'package:cab_rider/helpers/request_helper.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:geolocator/geolocator.dart';

class LocationHelper {
  static Future<String> findCoordinateAddress(Position position) async {
    String placeAddress = '';

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.mobile &&
        connectivityResult != ConnectivityResult.wifi) {
      return Future.value(placeAddress);
    }

    // https://maps.googleapis.com/maps/api/geocode/json?latlng=40.714224,-73.961452&key=YOUR_API_KEY
    Uri uri = Uri(
      scheme: 'https',
      host: 'maps.googleapis.com',
      path: 'maps/api/geocode/json',
      queryParameters: {
        'latlng': '${position.latitude},${position.longitude}',
        'key': mapKey,
      },
    );

    final response = await RequestHelper().getRequest(uri);

    if (response != 'failed') {
      placeAddress = response['results'][0]['formatted_address'];
      return Future.value(placeAddress);
    }

    return Future.value(placeAddress);
  }
}
