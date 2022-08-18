import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:intsite/int/int_repository.dart';
import 'package:intsite/int/view/view.dart';

import 'editor_repository.dart';

abstract class EditorStuff {
  String getTitle();

  // Route.
  Widget getHomePage(EditorStuff editorStuff);

// view, repo, bloc
  Widget getView();
  EditorRepository getEditorRepository();
  Bloc getBloc();
}
