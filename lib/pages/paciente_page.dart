import 'package:flutter/material.dart';
import 'package:koch_app/controllers.dart/controller_paciente.dart';
import 'package:koch_app/core/rest_client/dio_client.dart';
import 'package:koch_app/models/paciente.dart';
import 'package:koch_app/named_routes.dart';
import 'package:koch_app/repositories/paciente_repository.dart';

class PacientePage extends StatefulWidget {
  const PacientePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return PacientePageState();
  }
}

class PacientePageState extends State<PacientePage> {
  final controller = ControllerPaciente(
      pacienteRepository: PacienteRepository(restClient: DioClient()));

  @override
  void initState() {
    controller.buscarPacientes();
    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        if (controller.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        return Scaffold(
          appBar: AppBar(
            elevation: 1,
            backgroundColor: Colors.white,
            actions: [
              if (controller.searshing)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: TextFormField(
                      autofocus: true,
                      onChanged: controller.changeSearch,
                    ),
                  ),
                ),
              if (!controller.searshing)
                GestureDetector(
                  onTap: controller.changeSearshing,
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width - 50,
                    color: Colors.transparent,
                  ),
                ),
              IconButton(
                color: Colors.black,
                onPressed: controller.changeSearshing,
                icon: controller.searshing
                    ? const Icon(Icons.close)
                    : const Icon(Icons.search_sharp),
              ),
            ],
          ),
          body: Container(
            padding: const EdgeInsets.all(20),
            child: _Body(pacientes: controller.pacientes),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            onPressed: () =>
                {Navigator.pushNamed(context, AddPacienteViewRoute)},
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  final List<Paciente> pacientes;
  const _Body({required this.pacientes});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: pacientes.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => {
            Navigator.pushNamed(context, FichaViewRoute,
                arguments: pacientes[index]),
          },
          child: Card(
            elevation: 5.0,
            margin: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 12, right: 12, top: 10, bottom: 12),
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text(pacientes[index].nome),
                    textColor: Colors.white,
                    tileColor: Colors.red[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  ListTile(
                    title: Text(pacientes[index].unidadeTratamento),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
