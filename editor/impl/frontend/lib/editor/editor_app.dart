import 'package:flutter/material.dart';

import 'editor.dart';

class EditorApp extends StatelessWidget {
  final Editor editor;

  const EditorApp({required this.editor, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Instantiates app starting off with home page given by IntRoute
    return MaterialApp(
        title: editor.getTitle(), home: editor.getHomePage(editor));
  }
}
