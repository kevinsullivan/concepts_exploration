import 'package:editorsite/editor/bloc/editor_event.dart';

import '../editor/bloc/editor_homepage.dart';
import '../editor/editor_repository.dart';
import '../editor/editor.dart';
import 'bloc/int_bloc.dart';
import 'int_repository.dart';
import 'view/int_view.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:intapi/src/model/int.dart' as int_state;

class IntEditor extends Editor<int_state.Int> {
  //@override
  //Widget getHomePage(Editor<int_state.Int> e) {
  //  return EditorHomepage<int_state.Int>(e: e);
  //}

  @override
  String getTitle() {
    return "IntEditor";
  }

  @override
  Bloc<EditorEvent, int_state.Int> getBloc() {
    return IntBloc(repository: getEditorRepository());
  }

  @override
  EditorRepository getEditorRepository() {
    return IntEditorRepository();
  }

  @override
  Widget getView() {
    return IntView();
  }
}
