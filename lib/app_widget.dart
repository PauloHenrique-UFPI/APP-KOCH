import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:koch_app/componentization/app_controler.dart';
import 'package:koch_app/core/rest_client/dio_client.dart';
import 'package:koch_app/models/rest_client.dart';
import 'package:koch_app/named_routes.dart';
import 'package:koch_app/routes.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  void initState() {
    GetIt.I.registerLazySingleton<RestClient>(() => DioClient());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
        brightness: AppController.instance.temaDaAplicacao
            ? Brightness.dark
            : Brightness.light,
      ),
      //onGenerateRoute: generateRoute,
      routes: routes,
      initialRoute: InitialViemRoute,
    );
  }
}
