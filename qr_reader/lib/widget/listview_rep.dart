import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/Models/sacan_model.dart';
import 'package:qr_reader/provider/scan_list_provider.dart';
import 'package:qr_reader/utils/url_utils.dart';

class ScanTiles extends StatelessWidget {
  final String tipo;
  const ScanTiles({@required this.tipo});

  @override
  Widget build(BuildContext context) {
    final scanlistProvider = Provider.of<ScanListProvider>(context);
    final scan = scanlistProvider.scans;

    return ListView.builder(
      itemCount: scan.length,
      itemBuilder: (_, i) => Dismissible(
        key: UniqueKey(),
        background: Container(
          child: Icon(Icons.delete),
          color: Colors.red,
        ),
        onDismissed: (DismissDirection direction) {
          Provider.of<ScanListProvider>(context, listen: false)
              .borrarScanId(scan[i].id);
        },
        child: ListTile(
          leading: Icon(
            this.tipo == 'http' ? Icons.home_outlined : Icons.map_outlined,
            color: Theme.of(context).primaryColor,
          ),
          title: Text(scan[i].valor),
          subtitle: Text('Id: ${scan[i].id}'),
          trailing: Icon(
            Icons.keyboard_arrow_right,
            color: Colors.grey,
          ),
          onTap: () => launchURL(context, scan[i]),
        ),
      ),
    );
  }
}
