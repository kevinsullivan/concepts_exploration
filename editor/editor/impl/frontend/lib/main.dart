import 'package:flutter/material.dart';

import 'editor/editor.dart';
import 'editor/editor_app.dart';
import 'int/int_editor.dart';

void main() {
  Editor editor = IntEditor();
  runApp(EditorApp(editor: editor));
}
