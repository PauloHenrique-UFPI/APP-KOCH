import 'package:flutter/cupertino.dart';

class AppController extends ChangeNotifier {

  static AppController instance = AppController();//define a classe estatica dela mesma
  //aqui vamos fazer a funcionalidade de troca de tema de tema norturno para diurno e virce e versa
  bool temaDaAplicacao = false;//variavel que guarda o valor atual do tema.

  changeThema(){//metodo para modificar o tema
    temaDaAplicacao = !temaDaAplicacao;//recebe o contrario se for true vai para false e virce e versa
    notifyListeners();//notifica quem esta escutando (quem vai fazer uso da variavel)
  }

}