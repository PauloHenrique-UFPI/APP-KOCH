import 'package:flutter/material.dart';

class Paciente {
  int id;
  String nome;
  String dataN;
  String naturalidade;
  String profissao;
  String nomeMae;
  String forma;
  String cartaoSus;
  String endereco;
  String municipio;
  String pontoRef;
  String telefone;
  String nSinan;
  String unidadeTratamento;
  String unidadeCad;
  String imgTrat;

  Paciente({
    required this.id,
    required this.nome,
    required this.dataN,
    required this.naturalidade,
    required this.profissao,
    required this.nomeMae,
    required this.forma,
    required this.cartaoSus,
    required this.endereco,
    required this.municipio,
    required this.pontoRef,
    required this.telefone,
    required this.nSinan,
    required this.unidadeTratamento,
    required this.unidadeCad,
    required this.imgTrat,
  });

  factory Paciente.toMap(map) {
    return Paciente(
      id: map['id_paciente'] ?? 1,
      nome: map['nome'] ?? 'Paciente sem nome',
      dataN: map['data_nasc'] ?? '0000-00-00',
      naturalidade: map['naturalidade'] ?? 'Não Informado',
      profissao: map['profissao'] ?? 'Não Informado',
      nomeMae: map['nome_mae'] ?? 'Não Informado',
      forma: map['forma'] ?? 'Não Informado',
      cartaoSus: map['cartao_sus'] ?? 'Não Informado',
      endereco: map['endereco'] ?? 'Não Informado',
      municipio: map['municipio'] ?? 'Não Informado',
      pontoRef: map['ponto_ref'] ?? 'Não Informado',
      telefone: map['telefone'] ?? 'Não Informado',
      nSinan: map['n_sinan'] ?? 'Não Informado',
      unidadeTratamento: map['unidade_tratamento'] ?? 'Não Informado',
      unidadeCad: map['unidade_cad'] ?? 'Não Informado',
      imgTrat: map['img_trat'] ??
          'https://cdn-icons-png.flaticon.com/512/5110/5110429.png',
    );
  }
}
