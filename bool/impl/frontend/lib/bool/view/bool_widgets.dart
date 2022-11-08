import 'package:boolapp/bool/bloc/bool_bloc.dart' as bbloc;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Viewer extends StatelessWidget {
  const Viewer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<bbloc.BoolBloc, bbloc.BoolState>(
      builder: (context, state) {
        if (state.val) {
          return const Icon(Icons.invert_colors_sharp);
        } else {
          return const Icon(Icons.invert_colors_off_sharp);
        }
      },
    );
  }
}

class Get extends StatelessWidget {
  const Get({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text('Get'),
      onPressed: () {
        BlocProvider.of<bbloc.BoolBloc>(context).add(bbloc.Get());
      },
    );
  }
}

class Set extends StatefulWidget {
  const Set({super.key});

  @override
  State<Set> createState() => _SetState();
}

class _SetState extends State<Set> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
          BlocProvider.of<bbloc.BoolBloc>(context).add(bbloc.Set(val: value));
        });
      },
    );
  }
}
