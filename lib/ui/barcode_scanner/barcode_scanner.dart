import 'dart:async';

import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';

class BarcodeScannerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    scan();
    return new Container();
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      print(barcode);
      print('scanned');
    } catch (error) {
      print('error');
      print(error);
    }
  }
}
