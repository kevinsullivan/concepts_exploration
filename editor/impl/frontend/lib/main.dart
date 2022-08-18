import 'package:flutter/material.dart';

import 'editor/editor.dart';
import 'int/int_editor.dart';

void main() {
  runApp(GetSetApp(
    editor: IntEditor(),
  ));
}

class GetSetApp extends StatelessWidget {
  final Editor editor;

  const GetSetApp({required this.editor, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Instantiates app starting off with home page given by IntRoute
    return MaterialApp(
        title: editor.getTitle(), home: editor.getHomePage(editor));
  }
}
