import 'package:editorsite/editor/bloc/editor_event.dart' as eevents;
import 'package:editorsite/editor/editor_viewproxy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'collection_widget.dart';
import 'package:collectiongen/collectiongen.dart' as gen;

class CollectionView<T> extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [CollectionViewer<T>(), ButtonRow<T>()],
    );
  }
}

class ButtonRow<T> extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Init<T>(), Insert<T>(), Remove<T>()],
    );
  }
}
