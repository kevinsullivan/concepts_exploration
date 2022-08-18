import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:intsite/int/bloc/int_bloc.dart';
import 'package:intsite/int/int_repository.dart';
import 'package:intsite/int/view/view.dart';

import '../editorstuff/editor_repository.dart';
import '../editorstuff/editorstuff.dart';

class IntEditorStuff implements EditorStuff {
  @override
  Widget getHomePage(EditorStuff e) {
    return IntHomepage(e: e);
  }

  @override
  String getTitle() {
    return "IntEditor";
  }

  @override
  Bloc getBloc() {
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
