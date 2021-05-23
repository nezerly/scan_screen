import 'dart:async';

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:scan_screen/services/php_service.dart';
import 'package:scan_screen/services/user.dart';

class ScanScreen extends StatefulWidget {
  @override
  _ScanScreenState createState() => _ScanScreenState();
}
void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}

class _ScanScreenState extends State<ScanScreen> {
  Timer? _timer;
  ScanResult scanResult = new ScanResult();
  var student_id = _getUserID().toString();

  @override
  Widget build(BuildContext context) {
    configLoading();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: new Text(student_id),
          ),
          body: Center(
            child: ElevatedButton(
              onPressed: _scan,
              child: Text('Scan'),
            ),
          ),
        ));
  }

  @override
  void initState() {
    super.initState();
    EasyLoading.addStatusCallback((status) {
      print('EasyLoading Status $status');
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });
    // EasyLoading.showSuccess('Use in initState');
    // EasyLoading.removeCallbacks();
  }

  Future<void> _scan() async {
    try {
      final result = await BarcodeScanner.scan(
        options: ScanOptions(
          strings: {
            'cancel': "Cancel",
            'flash_on': "Flash On",
            'flash_off': "Flash Off",
          },
          restrictFormat: [],
          useCamera: -1,
          android: AndroidOptions(
            aspectTolerance: 0.5,
          ),
        ),
      );
      scanResult = result;
      var scanData;
      setState(() => {
            scanResult = result,
            scanData = {
              "barcode_event": scanResult.rawContent,
              "student_id": "700507",
              "student_name": "Ebenezer Agbekeye",
              "student_class": "2022"
            },
        _sendScan(scanData)
          });
    } on PlatformException catch (e) {
      setState(() {
        scanResult = ScanResult(
          type: ResultType.Error,
          format: BarcodeFormat.unknown,
          rawContent: e.code == BarcodeScanner.cameraAccessDenied
              ? 'The user did not grant the camera permission!'
              : 'Unknown error: $e',
        );
      });
    }
  }


  _sendScan(scanData) {
    saveScan(scanData);
  }
}

_getUserID() {
  return read();
}