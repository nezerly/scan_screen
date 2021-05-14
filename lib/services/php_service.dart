import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:scan_screen/models/scan_detail.dart';

Future<ScanDetail> fetchScans() async {
  final response =
      await http.get(Uri.https('jsonplaceholder.typicode.com', 'posts'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return ScanDetail.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<ScanDetail?> saveScan(myObject) async {
  final String apiUrl = "http://127.0.0.1:8000/api/attendance";
  final String part = "attendance";
  try {
    final response = await http.post(Uri.parse(apiUrl), headers: {"Content-Type": "application/json"}, body: jsonEncode(myObject));
    if (response.statusCode == 201) {
      final String responseString = response.body;

      print(responseString);
      // return userModelFromJson(responseString);
    } else {
      return null;
    }
  } catch (e) {
    // return e;
  }
}
