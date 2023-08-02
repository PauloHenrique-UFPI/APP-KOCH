import 'package:flutter/material.dart';
import 'login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // ignore: prefer_const_constructors
          title: Text(
            'TB-Koch',
            style: const TextStyle(
                fontSize: 16.0, color: Color.fromARGB(255, 26, 25, 25)),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: _Body(),
        ));
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(10),
        // ignore: prefer_const_literals_to_create_immutables
        child: Column(children: [
          // ignore: prefer_const_constructors
          SizedBox(
              width: 120,
              height: 120,
              // ignore: prefer_const_constructors
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(200),
                  child: const Image(
                    // ignore: prefer_const_constructors
                    image: NetworkImage(
                        'https://www.gov.br/planalto/pt-br/assuntos/assuntos-estrategicos/institucional/curriculos/avatar2.jpg/@@images/image'),
                  ))),
          const SizedBox(height: 10),

          //primeiras infos
          Text(
            'Paulo Dalessandro Pedro',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Text(
            'Admin@gmail.com',
            style: Theme.of(context).textTheme.headlineSmall,
          ),

          //Botao de logoff
          const SizedBox(height: 20),
          SizedBox(
              width: 250,
              child: ElevatedButton(
                onPressed: () {},
                // ignore: sort_child_properties_last
                child: const Text('Editar Perfil',
                    style: TextStyle(color: Colors.black87)),
                style: ElevatedButton.styleFrom(
                    side: BorderSide.none, shape: const StadiumBorder()),
              )),

          const SizedBox(height: 30),
          const Divider(),

          //MENU
          GestureDetector(
              onTap: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (route) => false),
              child: ListTile(
                leading: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.red.withOpacity(0.1)),
                  child: const Icon(Icons.settings),
                ),
                title: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.red),
                ),
              )),
        ]),
      ),
    );
  }
}
