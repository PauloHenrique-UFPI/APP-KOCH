// ignore_for_file: non_constant_identifier_names

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:koch_app/componentization/loading.dart';
import 'package:koch_app/validations_mixin.dart';
import '../models/rest_client.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../root.dart';

class AddNoticia extends StatefulWidget {
  const AddNoticia({super.key});

  @override
  State<AddNoticia> createState() => _AddNoticiaState();
}

class _AddNoticiaState extends State<AddNoticia> with ValidationsMixin {
  final _formKey = GlobalKey<FormState>();
  final _titulo = TextEditingController();
  final _descCurta = TextEditingController();
  final _desc = TextEditingController();
  final _img = TextEditingController();
  final httpClient = GetIt.I.get<RestClient>();
  final spinkit = const SpinKitWaveSpinner(
    color: Colors.red,
    size: 50.0,
  );
  File? _image;

  Future add(
      String titulo, String img, String desc_curta, String desc_longa) async {
    String mensagem;
    try {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          context = context;
          return const Loading();
        },
      );
      final response = await httpClient.post(
        '/create-new',
        {
          "titulo": titulo,
          "img": img,
          "desc_curta": desc_curta,
          "desc_longa": desc_longa,
        },
      );

      mensagem = response["message"];
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Sucesso!'),
            content: Text(mensagem),
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
            title: const Text('Ops!'),
            content: const Text('Algo deu errado'),
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

  @override
  Widget build(BuildContext context) {
    TextStyle _style() {
      return const TextStyle(
        fontFamily: 'RobotoMono',
        fontWeight: FontWeight.bold,
      );
    }

    Future<File?> _cropImage({required File imageFile}) async {
      CroppedFile? croppedImage =
          await ImageCropper().cropImage(sourcePath: imageFile.path);
      if (croppedImage == null) return null;
      return File(croppedImage.path);
    }

    Future _pickImage(ImageSource source) async {
      try {
        final image = await ImagePicker().pickImage(source: source);
        if (image == null) {
          return;
        }
        File? img = File(image.path);
        img = await _cropImage(imageFile: img);
        setState(() {
          _image = img;
        });
      } on PlatformException catch (e) {
        print(e);
      }
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
              IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
            ],
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
            )),
        body: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 12, right: 12, top: 10, bottom: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _titulo,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Um titulo para a noticia',
                        labelText: 'Titulo *',
                      ),
                      onSaved: (String? value) {},
                      validator: (value) => validacaoCompleta(
                        [
                          () => isNotEmpty(value),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Breve Descrição da noticia',
                        labelText: 'Prefácio *',
                      ),
                      validator: (value) => validacaoCompleta(
                        [
                          () => isNotEmpty(value),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      maxLines: null,
                      controller: _desc,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Noticia Completa *",
                      ),
                      validator: (value) => validacaoCompleta(
                        [
                          () => isNotEmpty(value),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (_image != null)
                      Image.file(
                        _image!,
                        height: 300,
                        width: 300,
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () => _pickImage(ImageSource.gallery),
                      child: const Text(
                        "Selecione uma imagem da galeria",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          onPressed: () => {
            if (_formKey.currentState!.validate())
              {
                add(_titulo.text, _img.text, _descCurta.text, _desc.text),
              }
          },
          child: const Icon(Icons.send),
        ),
      ),
    );
  }
}
