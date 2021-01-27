import 'package:flutter/cupertino.dart';

class UiPorvider extends ChangeNotifier {
  int _selectedMenuOpt = 1;

  int get selectedMenuOpt {
    return this._selectedMenuOpt;
  }

  set selectedMenuOpt(int value) {
    this._selectedMenuOpt = value;
    //Cuando se cambie el valor llamara esta funcion para notificar a todos los
    //Widget que esten escuchando la variable;
    notifyListeners();
  }
}
