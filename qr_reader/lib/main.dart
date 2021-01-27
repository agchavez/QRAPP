import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/pages/home_pages.dart';
import 'package:qr_reader/pages/map_pages.dart';
import 'package:qr_reader/provider/scan_list_provider.dart';
import 'package:qr_reader/provider/ui_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      //Lista de provider que necesita cada uno de los widget que se encuentren en el multiprovider(Al estar en el main toda al app tienen acceso a los provider)
      providers: [
        ChangeNotifierProvider(
          create: (_) => new UiPorvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => new ScanListProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QR Reader',
        initialRoute: 'home',
        routes: {
          'home': (BuildContext context) => HomePages(),
          'map': (_) => MapPages()
        },

        // Tema de la aplicacion, poder cambiar los colores por defecto de la aplicacion
        theme: ThemeData(
          primaryColor: Colors.indigo,
          floatingActionButtonTheme:
              FloatingActionButtonThemeData(backgroundColor: Colors.indigo),
        ),
      ),
    );
  }
}
