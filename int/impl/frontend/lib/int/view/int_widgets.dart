import 'package:intapp/int/bloc/int_bloc.dart' as ibloc;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Viewer extends StatelessWidget {
  const Viewer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ibloc.IntBloc, ibloc.IntState>(
        builder: (context, state) => Text(state.val.toString()));
  }
}

class Get extends StatelessWidget {
  const Get({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text('Get'),
      onPressed: () {
        BlocProvider.of<ibloc.IntBloc>(context).add(ibloc.Get());
      },
    );
  }
}

class Set extends StatelessWidget {
  const Set({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
            border: OutlineInputBorder(), hintText: 'Set'),
        onChanged: (String val) {
          final i = int.tryParse(val);
          if (i != null) {
            BlocProvider.of<ibloc.IntBloc>(context).add(ibloc.Set(val: i));
          }
        });
  }
}
