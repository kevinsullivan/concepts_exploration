import 'package:editorsite/editor/editor.dart';
import 'package:editorsite/editor/editor_app.dart';
import 'package:flutter/material.dart';

import 'int/int_editor.dart';

void main() {
  Editor editor = IntEditor();
  runApp(EditorApp(editor: editor));
}
