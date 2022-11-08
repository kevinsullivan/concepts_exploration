import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:boolapp/bool/bloc/bool_bloc.dart';
import 'package:boolapp/bool/bool_repository.dart';
import 'package:boolapp/bool/view/bool_layout.dart';

class BoolApp extends StatelessWidget {
  const BoolApp({super.key});

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
          appBar: AppBar(title: const Text(_title)),
          body: BlocProvider(
              create: (context) => BoolBloc(BoolRepository()),
              child: const Center(
                child: BoolLayout(),
              ))),
    );
  }
}
