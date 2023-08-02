class Prontuario {
  int id_prontuario;
  String tipo_entrada;
  String popu_especifica;
  String beneficiario;
  String tipo_doenca;
  String se_extrapulmonar;
  String agravos;
  String diagnostico;
  String radiografia;
  String hiv;
  String terapia;
  String data_inicio_tratamento_atual;
  String histopatologia;
  String cultura;
  String teste_sensibilidade;
  String contatos_identificados;

  Prontuario({
    required this.id_prontuario,
    required this.tipo_entrada,
    required this.popu_especifica,
    required this.beneficiario,
    required this.tipo_doenca,
    required this.se_extrapulmonar,
    required this.agravos,
    required this.diagnostico,
    required this.radiografia,
    required this.hiv,
    required this.terapia,
    required this.data_inicio_tratamento_atual,
    required this.histopatologia,
    required this.cultura,
    required this.teste_sensibilidade,
    required this.contatos_identificados,
  });

  factory Prontuario.fromJson(map) {
    return Prontuario(
      id_prontuario: map['id'] ?? 1,
      tipo_entrada: map['tipo'] ?? 'Não Informado',
      popu_especifica: map['popu_especifica'] ?? 'Não Informado',
      beneficiario: map['beneficiario'] ?? 'Não Informado',
      tipo_doenca: map['tipo_doenca'] ?? 'Não Informado',
      se_extrapulmonar: map['se_extrapulmonar'] ?? 'Não Informado',
      agravos: map['agravos'] ?? 'Não Informado',
      diagnostico: map['diagnostico'] ?? 'Não Informado',
      radiografia: map['radiografia'] ?? 'Não Informado',
      hiv: map['hiv'] ?? 'Não Informado',
      terapia: map['terapia'] ?? 'Não Informado',
      data_inicio_tratamento_atual: map['data_ini'] ?? 'Não Informado',
      histopatologia: map['histopatologia'] ?? 'Não Informado',
      cultura: map['cultura'] ?? 'Não Informado',
      teste_sensibilidade: map['teste_sens'] ?? 'Não Informado',
      contatos_identificados: map['contatos_ident'] ?? 'Não Informado',
    );
  }
}
