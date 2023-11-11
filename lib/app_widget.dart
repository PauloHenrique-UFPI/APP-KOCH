import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:koch_app/componentization/app_controler.dart';
import 'package:koch_app/core/rest_client/dio_client.dart';
import 'package:koch_app/models/rest_client.dart';
import 'package:koch_app/named_routes.dart';
import 'package:koch_app/preferencia_tema.dart';
import 'package:koch_app/routes.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    PreferenciaTema.setTema();
    GetIt.I.registerLazySingleton<RestClient>(() => DioClient());
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    PreferenciaTema.setTema();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: PreferenciaTema.tema,
      builder: (BuildContext context, Brightness tema, _) => MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.red,
          brightness: tema,
        ),
        routes: routes,
        initialRoute: InitialViemRoute,
      ),
    );
  }
}
