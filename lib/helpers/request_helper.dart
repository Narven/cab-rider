import 'dart:convert';

import 'package:http/http.dart' as http;

class RequestHelper {
  Future<dynamic> getRequest(Uri uri) async {
    // https://maps.googleapis.com/maps/api/geocode/json?latlng=40.714224,-73.961452&key=YOUR_API_KEY
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      print(response.statusCode);
    } catch (e) {
      rethrow;
    }
  }
}
