import 'package:built_collection/built_collection.dart';
import 'package:editorsite/editor/bloc/editor_event.dart';
import 'package:editorsite/editor/editor_viewproxy.dart';

import '../bloc/collection_bloc.dart';
import 'package:collectionapi/src/model/collection.dart' as cstate;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:built_value/json_object.dart';

import '../collection_editor.dart';

class Get extends StatelessWidget {
  final EditorViewProxy<cstate.Collection> val;

  const Get({required this.val, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      BlocBuilder<CollectionBlocType, cstate.Collection>(
          builder: (context, state) {
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
        decoration: const InputDecoration(
            border: OutlineInputBorder(), hintText: 'Set'),
        onChanged: (String val) {
          final cbuilder = cstate.CollectionBuilder();
          cbuilder.value.addAll(val.split(',').map((e) => JsonObject(e)));
          this.val.set(cbuilder.build());
        });
  }
}
