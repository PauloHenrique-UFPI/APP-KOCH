import 'package:flutter/material.dart';

import 'app_widget.dart';

import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting('pt_BR', null).then((_) => runApp(AppWidget()));
}
