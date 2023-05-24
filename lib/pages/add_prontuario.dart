import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:koch_app/validations_mixin.dart';
import '../models/rest_client.dart';
import '../root.dart';

class AddProntuario extends StatefulWidget {
  const AddProntuario({super.key});

  @override
  State<AddProntuario> createState() => _AddProntuarioState();
}

class _AddProntuarioState extends State<AddProntuario> with ValidationsMixin {
  int _activeStepIndex = 0;
  final _formKey = GlobalKey<FormState>();
  final _tipo_entrada = TextEditingController();
  final _popu_especifica = TextEditingController();
  final _beneficiario = TextEditingController();
  final _tipo_doenca = TextEditingController();
  final _se_extrapulmonar = TextEditingController();
  final _agravos = TextEditingController();
  final _diagnostico = TextEditingController();
  final _radiografia = TextEditingController();
  final _hiv = TextEditingController();
  final _terapia = TextEditingController();
  final _dateController = TextEditingController();
  final _histopatologia = TextEditingController();
  final _cultura = TextEditingController();
  final _teste_sensibilidade = TextEditingController();
  final _contatos_identificados = TextEditingController();
  final httpClient = GetIt.I.get<RestClient>();

  var tipoEntrada = [
    'Caso Novo',
    'Recidiva',
    'Reingresso',
    'Após Abandono',
    'Não Sabe',
    'Transferência',
    'Pós-Óbito',
  ];

  var populacoesEspeciais = [
    'Privado De Liberdade',
    'Profissional de Saúde',
    'População em Situação de Rua',
    'Imigrante',
    'Não',
    'Ignorado',
  ];

  var beneficiario = [
    'Sim',
    'Não',
    'Ignorado',
  ];

  var seExtrapulmonar = [
    'Pleural',
    'Gang.Perif.',
    'Geniturinária',
    'Óssea',
    'Ocular',
    'Miliar',
    'Meninogoencefálico',
    'Cutânea',
    'Laringea',
    'Outra',
    'Não Se Aplica',
  ];

  var forma = [
    'Pulmonar',
    'Extrapulmonar',
    'Pulmonar + Extrapulmonar',
    'Não Sabe',
  ];

  var doencaAgravaos = [
    'Aids',
    'Alcoolismo',
    'Diabetes',
    'Doença Mental',
    'Uso de Drogas Ilícitas',
    'Tabagismo',
    'Outras',
    'Não',
    'Ignorado',
  ];

  var baciloscopiaDiagnostico = [
    'Positiva',
    'Negativa',
    'Não Realizada',
    'Não se Aplica',
  ];

  var radiografiaTorax = [
    'Suspeito',
    'Normal',
    'Outra Patologia',
    'Não Realizado',
  ];

  var hiv = [
    'Positivo',
    'Negativo',
    'Em Andamento',
    'Não Realizado',
  ];

  var terapia = [
    'Sim',
    'Não',
    'Ignorado',
  ];

  var histopatologia = [
    'Baar Positivo',
    'Sugestivo de TB',
    'Não Sugestivo de TB',
    'Em Andamento',
    'Não Realizado',
  ];

  var cultura = [
    'Positivo',
    'Negativo',
    'Em Andamento',
    'Não Realizado',
  ];

  var testeSensibilidade = [
    'Resistente Somente à Isoniazida',
    'Resistente Somente à Rifampicina',
    'Resistente à Isoniazida e Rifampicina',
    'Resistente a Outras Drogas de 1a Linha',
    'Sensível',
    'Em Andamento',
    'Não Realizado',
  ];

  var contatosIdentificados = [
    '0 - 5',
    '6 - 10',
    '+10',
  ];

  String tipoEntradaValue = 'Não Sabe';
  String populacoesEspeciaisValue = 'Não';
  String beneficiarioValue = 'Não';
  String seExtrapulmonarValue = 'Não Se Aplica';
  String formaValue = 'Não Sabe';
  String doencaAgravaosValue = 'Não';
  String baciloscopiaDiagnosticoValue = 'Não Realizada';
  String radiografiaToraxValue = 'Não Realizado';
  String hivValue = 'Não Realizado';
  String terapiaValue = 'Não';
  String histopatologiaValue = 'Não Realizado';
  String culturaValue = 'Não Realizado';
  String testeSensibilidadeValue = 'Não Realizado';
  String contatosIdentificadosValue = '0 - 5';

  Future add(
    String tipo_entrada,
    String popu_especifica,
    String beneficiario,
    String tipo_doenca,
    String se_extrapulmonar,
    String agravos,
    String diagnostico,
    String radiografia,
    String hiv,
    String terapia,
    String data_inicio_tratamento_atual,
    String histopatologia,
    String cultura,
    String teste_sensibilidade,
    String contatos_identificados,
  ) async {
    String mensagem;

    DateTime data = DateFormat('d/M/yyyy').parse(data_inicio_tratamento_atual);
    String dataFormatada = DateFormat('yyyy-MM-dd').format(data);
    try {
      final response = await httpClient.post(
        '/create-paciente',
        {
          "tipo": tipo_doenca,
          "popu_especifica": popu_especifica,
          "beneficiario": beneficiario,
          "tipo_doenca": tipo_doenca,
          "se_extrapulmonar": se_extrapulmonar,
          "agravos": agravos,
          "diagnostico": diagnostico,
          "radiografia": radiografia,
          "hiv": hiv,
          "terapia": terapia,
          "data_ini": dataFormatada,
          "histopatologia": histopatologia,
          "cultura": cultura,
          "teste_sensi": teste_sensibilidade,
          "contatos_ident": contatos_identificados,
        },
      );

      mensagem = response["message"];
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Alerta'),
            content: Text(mensagem),
            // title: const Text('ERRO'),
            // content: const Text('Erro no servidor:'),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const Root()),
                    (route) => false,
                  );
                },
              ),
            ],
          );
        },
      );
    } catch (error) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Alerta'),
            content: Text('$error'),
            // title: const Text('ERRO'),
            // content: const Text('Erro no servidor:'),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat.yMd().format(picked);
      });
    }
  }

  List<Step> stepList() => [
        Step(
          state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 0,
          title: const Text('Parte 1'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Tipo de Entrada",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              DropdownButton(
                value: tipoEntradaValue,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: tipoEntrada.map((String tipoEntrada) {
                  return DropdownMenuItem(
                    value: tipoEntrada,
                    child: Text(tipoEntrada),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(
                    () {
                      tipoEntradaValue = newValue!;
                    },
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Populações Especias",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              DropdownButton(
                value: populacoesEspeciaisValue,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: populacoesEspeciais.map((String populacoesEspeciais) {
                  return DropdownMenuItem(
                    value: populacoesEspeciais,
                    child: Text(populacoesEspeciais),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(
                    () {
                      populacoesEspeciaisValue = newValue!;
                    },
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Beneficiario de Programas de Transferência de Renda do Governo",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              DropdownButton(
                value: beneficiarioValue,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: beneficiario.map((String beneficiario) {
                  return DropdownMenuItem(
                    value: beneficiario,
                    child: Text(beneficiario),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(
                    () {
                      beneficiarioValue = newValue!;
                    },
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Se Extrapulmonar",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              DropdownButton(
                value: seExtrapulmonarValue,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: seExtrapulmonar.map((String seExtrapulmonar) {
                  return DropdownMenuItem(
                    value: seExtrapulmonar,
                    child: Text(seExtrapulmonar),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(
                    () {
                      seExtrapulmonarValue = newValue!;
                    },
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Forma",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              DropdownButton(
                value: formaValue,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: forma.map((String forma) {
                  return DropdownMenuItem(
                    value: forma,
                    child: Text(forma),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(
                    () {
                      formaValue = newValue!;
                    },
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        Step(
          state: _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 1,
          title: const Text('Parte 2'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Doenças e Agravos Associados",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              DropdownButton(
                value: doencaAgravaosValue,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: doencaAgravaos.map((String doencaAgravaos) {
                  return DropdownMenuItem(
                    value: doencaAgravaos,
                    child: Text(doencaAgravaos),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(
                    () {
                      doencaAgravaosValue = newValue!;
                    },
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Baciloscipoa de Escarro (Diagnóstico)",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              DropdownButton(
                value: baciloscopiaDiagnosticoValue,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: baciloscopiaDiagnostico
                    .map((String baciloscopiaDiagnostico) {
                  return DropdownMenuItem(
                    value: baciloscopiaDiagnostico,
                    child: Text(baciloscopiaDiagnostico),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(
                    () {
                      baciloscopiaDiagnosticoValue = newValue!;
                    },
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Radiografia do Tórax",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              DropdownButton(
                value: radiografiaToraxValue,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: radiografiaTorax.map((String radiografiaTorax) {
                  return DropdownMenuItem(
                    value: radiografiaTorax,
                    child: Text(radiografiaTorax),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(
                    () {
                      radiografiaToraxValue = newValue!;
                    },
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "HIV",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              DropdownButton(
                value: hivValue,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: hiv.map((String hiv) {
                  return DropdownMenuItem(
                    value: hiv,
                    child: Text(hiv),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(
                    () {
                      hivValue = newValue!;
                    },
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Terapia Antirretroviral Durante o Tratamento para a TB",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              DropdownButton(
                value: terapiaValue,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: terapia.map((String terapia) {
                  return DropdownMenuItem(
                    value: terapia,
                    child: Text(terapia),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(
                    () {
                      terapiaValue = newValue!;
                    },
                  );
                },
              ),
            ],
          ),
        ),
        Step(
            state:
                _activeStepIndex <= 2 ? StepState.editing : StepState.complete,
            isActive: _activeStepIndex >= 2,
            title: const Text('Parte 3'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Histopatologia",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                DropdownButton(
                  value: histopatologiaValue,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: histopatologia.map((String histopatologia) {
                    return DropdownMenuItem(
                      value: histopatologia,
                      child: Text(histopatologia),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(
                      () {
                        histopatologiaValue = newValue!;
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Cultura",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                DropdownButton(
                  value: culturaValue,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: cultura.map((String cultura) {
                    return DropdownMenuItem(
                      value: cultura,
                      child: Text(cultura),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(
                      () {
                        culturaValue = newValue!;
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Teste de Sensibilidade",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                DropdownButton(
                  value: testeSensibilidadeValue,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: testeSensibilidade.map((String testeSensibilidade) {
                    return DropdownMenuItem(
                      value: testeSensibilidade,
                      child: Text(testeSensibilidade),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(
                      () {
                        testeSensibilidadeValue = newValue!;
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Total de Contatos Identificados",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                DropdownButton(
                  value: contatosIdentificadosValue,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items:
                      contatosIdentificados.map((String contatosIdentificados) {
                    return DropdownMenuItem(
                      value: contatosIdentificados,
                      child: Text(contatosIdentificados),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(
                      () {
                        contatosIdentificadosValue = newValue!;
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: AbsorbPointer(
                    child: TextFormField(
                      controller: _dateController,
                      keyboardType: TextInputType.datetime,
                      decoration: const InputDecoration(
                        labelText: 'Data de Nascimento',
                        hintText: 'Escolha uma data',
                        prefixIcon: Icon(Icons.calendar_today),
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Scaffold(
        appBar: AppBar(
            title: const Text(
              'TB-Koch',
              style: TextStyle(
                  fontSize: 12.0, color: Color.fromARGB(255, 26, 25, 25)),
            ),
            actions: <Widget>[
              IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
              //Customizavel(),
            ],
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
              //replace with our own icon data.
            )),
        body: Form(
          key: _formKey,
          child: Stepper(
            type: StepperType.horizontal,
            currentStep: _activeStepIndex,
            steps: stepList(),
            onStepContinue: () {
              if (_activeStepIndex < (stepList().length - 1)) {
                _activeStepIndex += 1;
              } else {
                if (_formKey.currentState!.validate()) {
                  add(
                    _tipo_entrada.text,
                    _popu_especifica.text,
                    _beneficiario.text,
                    _tipo_doenca.text,
                    _se_extrapulmonar.text,
                    _agravos.text,
                    _diagnostico.text,
                    _radiografia.text,
                    _hiv.text,
                    _terapia.text,
                    _dateController.text,
                    _histopatologia.text,
                    _cultura.text,
                    _teste_sensibilidade.text,
                    _contatos_identificados.text,
                  );
                }
              }
              setState(() {});
            },
            onStepCancel: () {
              if (_activeStepIndex == 0) {
                return;
              }
              _activeStepIndex -= 1;
              setState(() {});
            },
          ),
        ),
      ),
    );
  }
}
