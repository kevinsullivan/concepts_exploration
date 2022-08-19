import 'package:flutter/material.dart';

import 'collection/collection_editor.dart';
import 'package:editorsite/editor/editor_app.dart';

void main() {
  CollectionEditor editor = CollectionEditor();
  runApp(EditorApp(editor: editor));
}
