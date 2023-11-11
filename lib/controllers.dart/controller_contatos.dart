import 'package:flutter/material.dart';
import '../models/contatos.dart';
// import '../repositories/contatos_repository.dart';

class Controllercontato extends ChangeNotifier {
  String search = "";

  final _contatos = <Contato>[
    Contato(
        nome: "SUS",
        numero: "136",
        descricao:
            "O Sistema Único de Saúde (SUS) é um dos maiores e mais complexos sistemas de saúde pública do mundo, abrangendo desde o simples atendimento para avaliação da pressão arterial, por meio da Atenção Primária, até o transplante de órgãos, garantindo acesso integral, universal e gratuito para toda a população do país."),
    Contato(
        nome: "Secretária de Saúde",
        numero: "160",
        descricao:
            "Compete à Secretaria Municipal de Saúde, no âmbito local, dirigir o Sistema Único de Saúde (SUS) e promover, gerir, planejar, organizar e controlar a execução das ações e dos serviços de saúde desenvolvidos pelo Município."),
    Contato(
        nome: "Bombeiros",
        numero: "193",
        descricao:
            "Bombeiros são entidades da Proteção Civil cujos membros são treinados para atuarem em caso de incêndios, para resgatar pessoas de acidentes de trânsito, desmoronamentos de edifícios, desastres naturais, salvamento em grande ângulo."),
    Contato(
        nome: "Samu",
        numero: "192",
        descricao:
            "O Serviço de Atendimento Móvel de Urgência (SAMU) tem como objetivo chegar precocemente à vítima após ter ocorrido alguma situação de urgência ou emergência que possa levar a sofrimento, a sequelas ou mesmo à morte. São urgências situações de natureza clínica, cirúrgica, traumática, obstétrica, pediátrica, psiquiátrica, entre outras."),
    Contato(
        nome: "Pocícia militar",
        numero: "190",
        descricao:
            "A polícia militar, segundo o conceito usado internacionalmente, é a corporação que exerce o poder de polícia no âmbito interno das forças armadas, garantindo a segurança, a ordem e a lei no seu seio."),
  ];

  bool loading = false;
  bool searshing = false;

  void changeSearch(String key) {
    search = key;
    notifyListeners();
  }

  void changeSearshing() {
    searshing = !searshing;
    if (!searshing) search = "";
    notifyListeners();
  }

  List<Contato> get contatos {
    return _contatos
        .where((e) => e.nome.toLowerCase().contains(search.toLowerCase()))
        .toList();
  }
}
