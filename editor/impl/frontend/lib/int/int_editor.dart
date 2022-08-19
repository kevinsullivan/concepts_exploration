import 'package:editorsite/editor/bloc/editor_event.dart';

import '../editor/editor_repository.dart';
import '../editor/editor.dart';
import 'bloc/int_bloc.dart';
import 'int_repository.dart';
import 'view/int_view.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:intapi/src/model/int.dart' as int_state;

typedef IntBlocType = Bloc<EditorEvent, int_state.Int>;

class IntEditor extends Editor<int_state.Int> {
  @override
  String getTitle() {
    return "IntEditor";
  }

  @override
  IntBlocType getBloc() {
    return IntEditorBloc(repository: getEditorRepository());
  }

  @override
  EditorRepository<int_state.Int> getEditorRepository() {
    return IntEditorRepository();
  }

  @override
  Widget getView() {
    return IntView();
  }
}
