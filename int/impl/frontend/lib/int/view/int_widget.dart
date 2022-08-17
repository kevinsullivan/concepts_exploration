import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intapi/src/model/int.dart' as int_state;
import 'package:intsite/int/bloc/int_bloc.dart';
import '../Int.dart';

class Get extends StatelessWidget {
  final Int val;

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
  final Int val;

  const Set({required this.val, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
            border: OutlineInputBorder(), hintText: 'Set'),
        onChanged: (String val) {
          this.val.set(int.parse(val));
        });
  }
}
