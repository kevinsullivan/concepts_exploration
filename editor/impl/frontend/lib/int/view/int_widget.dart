import 'package:editorsite/editor/editor_viewproxy.dart';

import '../bloc/int_bloc.dart';

import 'package:intapi/src/model/int.dart' as int_state;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Get extends StatelessWidget {
  final EditorViewProxy val;

  const Get({required this.val, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      BlocBuilder<IntBloc, int_state.Int>(builder: (context, state) {
        val.state = state;
        return Text(val.state.value!.toString());
      }),
      ElevatedButton(
        child: const Text('Get'),
        onPressed: () {
          val.get();
        },
      )
    ]);
  }
}

class Set extends StatelessWidget {
  final EditorViewProxy val;

  const Set({required this.val, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
            border: OutlineInputBorder(), hintText: 'Set'),
        onChanged: (String val) {
          final builder = int_state.IntBuilder();
          builder.value = int.parse(val);
          this.val.set(builder.build());
        });
  }
}
