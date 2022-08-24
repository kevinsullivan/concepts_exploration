import 'package:editorsite/editor/bloc/editor_event.dart' as eevents;
import 'package:editorsite/editor/editor_viewproxy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../int_editor.dart';
import "int_widget.dart";
import "package:intapi/src/model/int.dart" as int_state;

class IntView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final i = EditorViewProxy<int_state.Int>(bloc: context.read<IntBlocType>());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Get(val: i), Set(val: i)],
    );
  }
}
