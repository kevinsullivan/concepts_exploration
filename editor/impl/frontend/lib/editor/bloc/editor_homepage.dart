import 'package:editorsite/editor/bloc/editor_event.dart';

import '../../editor/editor.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/*
This hand-crafted file defines the home page of the 
GetSet app, constructed using build, returning bloc 
provider that provides access to IntBloc
*/
class EditorHomepage<T> extends StatelessWidget {
  final Editor<T> e;
  const EditorHomepage({required this.e, Key? key}) : super(key: key);

  @override
  /*
  Creates the BlocProvider widget that creates an IntBloc and exposes
  it to the IntView
  */
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => e.getBloc(),
        child: Scaffold(body: Center(child: e.getView())));
  }
}
