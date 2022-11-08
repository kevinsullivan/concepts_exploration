import 'package:boolapp/bool/bool_app.dart';
import 'package:flutter/material.dart';
import 'package:freecompose/freecompose/app_grid.dart';
import 'package:intapp/int/int_app.dart';

class FreeComposeApp extends StatelessWidget {
  const FreeComposeApp({super.key});

  static const String _title = 'Free Composition';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: _title,
        home: Scaffold(
            appBar: AppBar(title: const Text(_title)),
            body: const AppGrid(
                apps: [IntApp(), BoolApp(), BoolApp(), IntApp()])));
  }
}
