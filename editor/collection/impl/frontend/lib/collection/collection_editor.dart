import 'package:editorsite/editor/bloc/editor_event.dart';
import 'package:editorsite/editor/editor.dart';
import 'package:editorsite/editor/editor_repository.dart';

import 'bloc/collection_bloc.dart';
import 'collection_repository.dart';
import 'view/collection_view.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:collectionapi/src/model/collection.dart' as cstate;

typedef CollectionBlocType = Bloc<EditorEvent, cstate.Collection>;

class CollectionEditor extends Editor<cstate.Collection> {
  @override
  String getTitle() {
    return "CollectionEditor";
  }

  @override
  CollectionBlocType getBloc() {
    return CollectionEditorBloc(repository: getEditorRepository());
  }

  @override
  EditorRepository<cstate.Collection> getEditorRepository() {
    return CollectionEditorRepository();
  }

  @override
  Widget getView() {
    return CollectionView();
  }
}
