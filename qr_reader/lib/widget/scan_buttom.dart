import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/provider/scan_list_provider.dart';
import 'package:qr_reader/utils/url_utils.dart';

class ScanButtom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0.0,
      child: Icon(Icons.filter_center_focus),
      onPressed: () async {
        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
            '#3D8BEF', 'Cancelar', false, ScanMode.QR);
        //final barcodeScan = 'geo:14.073060069450303,-87.19175893427561';
        if (barcodeScanRes == '-1') {
          return;
        }

        final scanlistProvider =
            Provider.of<ScanListProvider>(context, listen: false);
        final newScan = await scanlistProvider.nuevoscan(barcodeScanRes);
        launchURL(context, newScan);
      },
    );
  }
}
