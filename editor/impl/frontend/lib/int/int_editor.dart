import '../editor/editor_repository.dart';
import '../editor/editor.dart';
import 'bloc/int_bloc.dart';
import 'int_repository.dart';
import 'view/int_homepage.dart';
import 'view/int_view.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class IntEditor implements Editor {
  @override
  Widget getHomePage(Editor e) {
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
