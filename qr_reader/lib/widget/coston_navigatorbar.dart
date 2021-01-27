import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/provider/ui_provider.dart';

class CustomNavigatorBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UiPorvider>(context);
    final currentIndex = provider.selectedMenuOpt;
    //Con la propiedad onTap se ejecuta cada vez que precionamos una de las opciones
    //del BottonNavigationBar en este caso al solo tener 2 opciones solo puede ser 0 y 1
    return BottomNavigationBar(
      onTap: (int i) => provider.selectedMenuOpt = i,
      currentIndex: currentIndex,
      elevation: 0,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Mapa'),
        BottomNavigationBarItem(
            icon: Icon(Icons.compass_calibration), label: 'Home'),
      ],
    );
  }
}
