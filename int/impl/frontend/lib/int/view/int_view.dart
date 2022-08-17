import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intsite/int/bloc/int_bloc.dart';
import '../Int.dart';
import "int_widget.dart";

class IntView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final i = Int(intbloc: context.read<IntBloc>());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Get(val: i), Set(val: i)],
    );
  }
}
