import 'package:flutter/cupertino.dart';
import 'package:qr_reader/Models/sacan_model.dart';
import 'package:url_launcher/url_launcher.dart';

launchURL(BuildContext context, ScanModel scan) async {
  final url = scan.valor;
  if (scan.tipo == 'http') {
    //Abrir el sitio web
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  } else {
    Navigator.pushNamed(context, 'map', arguments: scan);
  }
}
