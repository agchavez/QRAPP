import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:qr_reader/Models/sacan_model.dart';

class DBprovider {
  static Database _database;
  static final DBprovider db = DBprovider._();

  //Constructor privado
  DBprovider._();

  Future<Database> get database async {
    //En el caso que ya hay una instancia de la base de datos retorndamos la misma instalacio
    // caso contrario hacemos una nueva peticion e instancia.
    if (_database != null) return _database;

    _database = await initDB();

    return _database;
  }

  Future<Database> initDB() async {
    // Path de donde almacenaremos la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    //Unir tanto la direccion donde se almacenara la base de datos como el nombre de la base de datos
    final path = join(documentsDirectory.path, 'ScansDB.db');

    //Crear la base de datos cuando se hacen cambios se recomienda aunmentar el valor de la version de la base de datos
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE Scan(
          id INTEGER PRIMARY KEY,
          tipo TEXT,
          valor TEXT
        )
         ''');
    });
  }

  //Ingresar datos a las tablas con rawinsert
  Future<int> nuevoScanRaw(ScanModel newScam) async {
    final id = newScam.id;
    final tipo = newScam.tipo;
    final valor = newScam.valor;
    //Verificar la base de datos.
    final db = await database;

    final res = await db.rawInsert('''
      INSERT INTO Scan(id, tipo, valor) VALUES
      ( $id,'$tipo', '$valor')
    ''');
  }

  //Ingresar datos a las tablas con
  Future<int> newScan(ScanModel newScanValue) async {
    final db = await database;
    final res = await db.insert('Scan', newScanValue.toJson());

    //Retornar el id del valor ingresado
    return res;
  }

  //Consultas de registros segun el id
  Future<ScanModel> getScanById(int id) async {
    final db = await database;

    final res = await db.query('Scan', where: 'id=?', whereArgs: [id]);

    return res.isNotEmpty ? ScanModel.fromJson(res[0]) : null;
  }

  //Cosulta de todos los registros
  Future<List<ScanModel>> getScans() async {
    final db = await database;

    final res = await db.query('Scan');
    return res.isNotEmpty
        ? res.map((scan) => ScanModel.fromJson(scan)).toList()
        : [];
  }

  //Cosulta de todos los registros por tipo
  Future<List<ScanModel>> getScansPortipo(String tipo) async {
    final db = await database;

    final res = await db.rawQuery('''
    SELECT * FROM Scan WHERE tipo = '$tipo'
    ''');
    return res.isNotEmpty
        ? res.map((scan) => ScanModel.fromJson(scan)).toList()
        : [];
  }

  // Actualizar registro
  Future<int> updateScan(ScanModel newscan) async {
    final db = await database;
    final res = await db.update('Scan', newscan.toJson(),
        where: 'id=?', whereArgs: [newscan.id]);

    return res;
  }

  //Eliminar registro
  Future<int> deleteScan(int id) async {
    final db = await database;
    final res = await db.delete('Scan', where: 'id=?', whereArgs: [id]);

    return res;
  }

  //Eliminar todos los registro
  Future<int> deleteAllScans() async {
    final db = await database;
    final res = await db.rawDelete('''
      DELETE FROM Scan
    ''');

    return res;
  }
}
