import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/Models/sacan_model.dart';
import 'package:qr_reader/pages/direcciones_pages.dart';
import 'package:qr_reader/pages/map_pages.dart';
import 'package:qr_reader/pages/maps_page.dart';
import 'package:qr_reader/provider/db_provider.dart';
import 'package:qr_reader/provider/scan_list_provider.dart';
import 'package:qr_reader/provider/ui_provider.dart';
import 'package:qr_reader/widget/coston_navigatorbar.dart';
import 'package:qr_reader/widget/scan_buttom.dart';

class HomePages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {
              Provider.of<ScanListProvider>(context, listen: false)
                  .borrarTodos();
            },
          )
        ],
      ),
      body: _HomePagesBody(),
      bottomNavigationBar: CustomNavigatorBar(),
      floatingActionButton: ScanButtom(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

//Inforamcion mostrada en el body del home pages
//Utilizando el customNavigatorBar
class _HomePagesBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Obtener el selected menu opt
    final provider = Provider.of<UiPorvider>(context);

    //Cambiar para mostrar la pagina
    final currentIndex = provider.selectedMenuOpt;

    //TODO: Temporal leer la DB
    //DBprovider.db.deleteAllScans();

    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);

    //Mostrar mapas en base al menu seleccionado
    switch (currentIndex) {
      case 0:
        scanListProvider.cargarScansTipo('geo');
        return MapsPage();

      case 1:
        scanListProvider.cargarScansTipo('http');
        return DireccionesPage();
      default:
        return MapsPage();
    }
  }
}
