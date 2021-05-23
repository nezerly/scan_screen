
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:scan_screen/screens/saveUserDetails.dart';
import 'package:scan_screen/screens/scanScreen.dart';

import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  home: SaveUserDetails(),
  builder: EasyLoading.init(),
));
