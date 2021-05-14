import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scan_screen/services/convert_result.dart';
import 'package:scan_screen/services/php_service.dart';

class ScanScreen extends StatefulWidget {
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  ScanResult scanResult = new ScanResult();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Scan Now'),
          ),
          body: Center(
            child: ElevatedButton(
              onPressed: _scan,
              child: Text('Scan'),
            ),
          ),
        ));
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
          autoEnableFlash: false,
          android: AndroidOptions(
            aspectTolerance: 0.5,
            useAutoFocus: true,
          ),
        ),
      );
      scanResult = result;
      var scanData;
      setState(() =>
      {
        scanResult = result,
          scanData = {
          "rawContent": scanResult.rawContent,
          "studentIndex": '700507',
          "studentName": 'Ebenezer AGbekeye',
          "studentClass": '2022'
          }
      });
      _sendScan(scanData);
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
