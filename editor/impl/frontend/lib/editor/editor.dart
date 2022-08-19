import 'package:bloc/bloc.dart';
import 'package:editorsite/editor/bloc/editor_homepage.dart';
import 'package:flutter/material.dart';

import 'bloc/editor_event.dart';
import 'editor_repository.dart';

abstract class Editor<T> {
  String getTitle();

  Widget getHomePage(Editor<T> e) {
    // Default impl.
    return EditorHomepage<T>(e: e);
  }

  Widget getView();
  EditorRepository getEditorRepository();
  Bloc<EditorEvent, T> getBloc();
}
