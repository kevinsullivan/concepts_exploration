import 'package:editorsite/editor/bloc/editor_event.dart' as eevents;
import 'package:editorsite/editor/editor_viewproxy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../collection_editor.dart';
import 'collection_widget.dart';

import 'package:collectionapi/src/model/collection.dart' as cstate;

class CollectionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final i = EditorViewProxy<cstate.Collection>(
        bloc: context.read<CollectionBlocType>());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Get(val: i), Create(val: i)],
    );
  }
}
