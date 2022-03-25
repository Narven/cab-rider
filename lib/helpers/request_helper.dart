import 'dart:convert';

import 'package:http/http.dart' as http;

class RequestHelper {
  Future<dynamic> getRequest<T>(Uri uri) async {
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
