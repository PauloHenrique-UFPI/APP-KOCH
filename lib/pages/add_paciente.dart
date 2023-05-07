import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:koch_app/validations_mixin.dart';

import '../core/rest_client/rest_client.dart';
import '../root.dart';

class AddPacientes extends StatefulWidget {
  const AddPacientes({super.key});

  @override
  State<AddPacientes> createState() => _AddPacientesState();
}

class _AddPacientesState extends State<AddPacientes> with ValidationsMixin {
  int _activeStepIndex = 0;
  final _formKey = GlobalKey<FormState>();
  final _nome = TextEditingController();
  final _dateController = TextEditingController();
  final _naturalidade = TextEditingController();
  final _profissao = TextEditingController();
  final _nomeMae = TextEditingController();
  final _forma = TextEditingController();
  final _cartaosus = TextEditingController();
  final _endreco = TextEditingController();
  final _municipio = TextEditingController();
  final _pontoRef = TextEditingController();
  final _telefone = TextEditingController();
  final _numSinan = TextEditingController();
  final _unidTratamento = TextEditingController();
  final _unidCadastro = TextEditingController();
  final httpClient = GetIt.I.get<RestClient>();

  Future add(
      String nome,
      String dNasc,
      String naturalidade,
      String profissao,
      String nomeMae,
      String forma,
      String cartaoSus,
      String endereco,
      String municipio,
      String pontoRef,
      String telefone,
      String nSinan,
      String unidadeTratamento,
      String unidadeCadastro) async {
    String mensagem;
    int intTryParse = int.tryParse(forma) ?? 0;

    DateTime data = DateFormat('d/M/yyyy').parse(dNasc);
    String dataFormatada = DateFormat('yyyy-MM-dd').format(data);
    try {
      final response = await httpClient.post(
        '/create-paciente',
        {
          "nome": nome,
          "data_nasc": dataFormatada,
          "naturalidade": naturalidade,
          "profissao": profissao,
          "nome_mae": nomeMae,
          "forma": intTryParse,
          "cartao_sus": cartaoSus,
          "endereco": endereco,
          "municipio": municipio,
          "ponto_ref": pontoRef,
          "telefone": telefone,
          "n_sinan": nSinan,
          "unidade_tratamento": unidadeTratamento,
          "unidade_cad": unidadeCadastro
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
                    MaterialPageRoute(builder: (context) => Root()),
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
          title: const Text('Dados Pessoais'),
          content: Column(children: [
            TextFormField(
              controller: _nome,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Nome Completo",
              ),
              validator: (value) => validacaoCompleta([
                () => isNotEmpty(value),
              ]),
            ),
            const SizedBox(
              height: 8,
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
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              controller: _naturalidade,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Naturalidade",
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _profissao,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: "Profissão"),
              validator: (value) => validacaoCompleta([
                () => isNotEmpty(value),
              ]),
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              controller: _nomeMae,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Nome da Mãe",
              ),
              validator: (value) => validacaoCompleta([
                () => isNotEmpty(value),
              ]),
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              controller: _forma,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Forma: ",
              ),
              validator: (value) => validacaoCompleta([
                () => isNotEmpty(value),
              ]),
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              "1 - Pulmonar  2 - Negativa  3 - Não Realizada 4 - Não se Aplica",
              style: TextStyle(fontSize: 12),
            ),
          ]),
        ),
        Step(
          state: _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 1,
          title: const Text('Endereço'),
          content: Column(children: [
            TextFormField(
              controller: _endreco,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Endereço",
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              controller: _municipio,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Municipio",
              ),
              validator: (value) => validacaoCompleta([
                () => isNotEmpty(value),
              ]),
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              controller: _pontoRef,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Ponto de Referencia",
              ),
              validator: (value) => validacaoCompleta([
                () => isNotEmpty(value),
              ]),
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              controller: _telefone,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Telefone: ",
              ),
              validator: (value) => validacaoCompleta([
                () => isNotEmpty(value),
              ]),
            ),
          ]),
        ),
        Step(
            state:
                _activeStepIndex <= 2 ? StepState.editing : StepState.complete,
            isActive: _activeStepIndex >= 2,
            title: const Text('SUS'),
            content: Column(
              children: [
                TextFormField(
                  controller: _cartaosus,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Numero do Cartão do SUS: ",
                  ),
                  validator: (value) => validacaoCompleta([
                    () => isNotEmpty(value),
                  ]),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _numSinan,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Número do Sinan: ",
                  ),
                  validator: (value) => validacaoCompleta([
                    () => isNotEmpty(value),
                  ]),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _unidTratamento,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Unidade de Tratamento",
                  ),
                  validator: (value) => validacaoCompleta([
                    () => isNotEmpty(value),
                  ]),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _unidCadastro,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Unidade de Cadastro",
                  ),
                  validator: (value) => validacaoCompleta([
                    () => isNotEmpty(value),
                  ]),
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
                  fontSize: 16.0, color: Color.fromARGB(255, 26, 25, 25)),
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
                      _nome.text,
                      _dateController.text,
                      _naturalidade.text,
                      _profissao.text,
                      _nomeMae.text,
                      _forma.text,
                      _cartaosus.text,
                      _endreco.text,
                      _municipio.text,
                      _pontoRef.text,
                      _telefone.text,
                      _numSinan.text,
                      _unidTratamento.text,
                      _unidCadastro.text);
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
