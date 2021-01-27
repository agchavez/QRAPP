import 'package:flutter/cupertino.dart';
import 'package:qr_reader/Models/sacan_model.dart';
import 'package:qr_reader/provider/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String tipoSeleccionado = 'http';

  //Constructor
  ScanListProvider();

  Future<ScanModel> nuevoscan(String valor) async {
    final nuevoScan = new ScanModel(valor: valor);
    final id = await DBprovider.db.newScan(nuevoScan);

    //Asignar el id de la base de datos al modelo
    nuevoScan.id = id;

    //Agregar el nuevo scan a la lista y notificar los cambios
    //Solo si el tipo seleccionado es el mismo
    if (this.tipoSeleccionado == nuevoScan.tipo) {
      this.scans.add(nuevoScan);
      notifyListeners();
    }

    return nuevoScan;
  }

  caragrScans() async {
    final scans = await DBprovider.db.getScans();

    //Sustiruir los scans almacenados anteriormente
    this.scans = [...scans];
    notifyListeners();
  }

  cargarScansTipo(String tipo) async {
    final scans = await DBprovider.db.getScansPortipo(tipo);

    //Sustiruir los scans almacenados anteriormente pero filtrando por tipos
    this.scans = [...scans];
    this.tipoSeleccionado = tipo;
    notifyListeners();
  }

  borrarScanId(int id) async {
    await DBprovider.db.deleteScan(id);
    cargarScansTipo(this.tipoSeleccionado);
  }

  borrarTodos() async {
    await DBprovider.db.deleteAllScans();
    this.scans = [];
    notifyListeners();
  }
}
