import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'editor_repository.dart';

abstract class Editor {
  String getTitle();

  Widget getHomePage(Editor editorStuff);
  Widget getView();
  EditorRepository getEditorRepository();
  Bloc getBloc();
}
