import 'package:flutter/material.dart';
import 'package:intsite/int/view/view.dart';

import 'editorstuff/editorstuff.dart';
import 'int/int_editorstuff.dart';

void main() {
  runApp(GetSetApp(
    editorStuff: IntEditorStuff(),
  ));
}

class GetSetApp extends StatelessWidget {
  final EditorStuff editorStuff;

  const GetSetApp({required this.editorStuff, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Instantiates app starting off with home page given by IntRoute
    return MaterialApp(
        title: editorStuff.getTitle(),
        home: editorStuff.getHomePage(editorStuff));
  }
}
