import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:koch_app/validations_mixin.dart';

class AddPacientes extends StatefulWidget {
  const AddPacientes({super.key});

  @override
  State<AddPacientes> createState() => _AddPacientesState();
}

class _AddPacientesState extends State<AddPacientes> with ValidationsMixin {
  int _activeStepIndex = 0;
  final TextEditingController _nome = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _naturalidade = TextEditingController();
  final TextEditingController _profissao = TextEditingController();
  final TextEditingController _nomeMae = TextEditingController();
  final TextEditingController _forma = TextEditingController();
  final TextEditingController _cartaosus = TextEditingController();
  final TextEditingController _endreco = TextEditingController();
  final TextEditingController _municipio = TextEditingController();
  final TextEditingController _pontoRef = TextEditingController();
  final TextEditingController _telefone = TextEditingController();
  final TextEditingController _numSinan = TextEditingController();
  final TextEditingController _unidTratamento = TextEditingController();
  final TextEditingController _unidCadastro = TextEditingController();

  List<Step> stepList() => [
        Step(
          state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 0,
          title: const Text('Dados Pessoais'),
          content: Container(
            child: Column(children: [
              TextFormField(
                controller: _nome,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Nome Completo",
                ),
                validator: (value) => validacaoCompleta([
                  () => isNotEmpty(value),
                  () => hasFiveChars(value),
                ]),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.calendar_today_rounded),
                  border: OutlineInputBorder(),
                  labelText: "Data de Nascimento",
                ),
                onTap: () async {
                  await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  );
                },
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
                  () => hasFiveChars(value),
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
                  () => hasFiveChars(value),
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
                  () => hasFiveChars(value),
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
        ),
        Step(
          state: _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 1,
          title: const Text('Endereço'),
          content: Container(
            child: Column(children: [
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
                  () => hasFiveChars(value),
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
                  () => hasFiveChars(value),
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
                  () => hasFiveChars(value),
                ]),
              ),
            ]),
          ),
        ),
        Step(
            state:
                _activeStepIndex <= 2 ? StepState.editing : StepState.complete,
            isActive: _activeStepIndex >= 2,
            title: const Text('SUS'),
            content: Container(
                child: Column(
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
                    () => hasFiveChars(value),
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
                    () => hasFiveChars(value),
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
                    () => hasFiveChars(value),
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
                    () => hasFiveChars(value),
                  ]),
                ),
              ],
            ))),
      ];

  @override
  Widget build(BuildContext context) {
    TextStyle _style() {
      return const TextStyle(
        fontFamily: 'RobotoMono',
        fontWeight: FontWeight.bold,
      );
    }

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
              IconButton(
                  icon: const Icon(Icons.supervised_user_circle_outlined),
                  onPressed: () {}),
              //Customizavel(),
            ],
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
              //replace with our own icon data.
            )),
        body: Stepper(
          type: StepperType.horizontal,
          currentStep: _activeStepIndex,
          steps: stepList(),
          onStepContinue: () {
            if (_activeStepIndex < (stepList().length - 1)) {
              _activeStepIndex += 1;
            }
            if (_activeStepIndex == 3) {}
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
    );
  }
}
