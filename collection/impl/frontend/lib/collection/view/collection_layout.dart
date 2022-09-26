import 'package:editorsite/editor/bloc/editor_event.dart' as eevents;
import 'package:editorsite/editor/editor_viewproxy.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../composedcollection/compositor.dart';
import 'collection_widgets.dart';
import 'package:collectiongen/collectiongen.dart' as gen;

class CollectionLayout<T> extends StatelessWidget {
  WidgetFromStateBuilder<T> tbuilder;

  CollectionLayout({Key? key, required this.tbuilder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [CollectionViewer<T>(widgetFromState: tbuilder), ButtonRow<T>()],
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
