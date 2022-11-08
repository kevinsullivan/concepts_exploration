import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intapp/int/bloc/int_bloc.dart';
import 'package:intapp/int/int_repository.dart';
import 'package:intapp/int/view/int_layout.dart';

class IntApp extends StatelessWidget {
  const IntApp({super.key});

  static const String _title = 'Int Concept';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
          appBar: AppBar(title: const Text(_title)),
          body: BlocProvider(
              create: (context) => IntBloc(IntRepository()),
              child: const Center(
                child: IntLayout(),
              ))),
    );
  }
}
