import '../bloc/int_bloc.dart';
import '../getset_viewproxy_int.dart';

import 'package:intapi/src/model/int.dart' as int_state;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Get extends StatelessWidget {
  final GetSet_ViewProxy_int val;

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
  final GetSet_ViewProxy_int val;

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
