import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
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
  final String apiUrl = "https://abs-att-back.000webhostapp.com/api/create.php";
  final String part = "attendance";

  EasyLoading.show(status: 'loading...');

    final response = await http.post(Uri.parse(apiUrl), headers: {"Content-Type": "application/json"}, body: jsonEncode(myObject));
    var res = json.decode(response.body);
    print(res);
  if (res == "empty") {
      EasyLoading.showError('NO SCAN, Try again');
  }
  //
  if (res == "success") {
      EasyLoading.showSuccess('Attendance submitted!');
    }
  else if(res == "error"){
      EasyLoading.showError('Failed with Error, try again');
    }
}
