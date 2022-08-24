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

  /*
  Crucial class providing required "typeclass" implementation to
  make objects of some type, T, editable.

  MAJOR TODO: What else goes in this list, even if provided only
  statically (e.g., in files elsewhere in the project)? An example
  would be required entries in an api.yaml file, of definitions
  of classes instances of which are used to signal requests for
  procedure invocations from UIs to blocs (as currently done in
  this project).
  */

  @override
  String getTitle() {
    return "CollectionEditor";
  }

  @override
  Widget getView() {
    return CollectionView();
  }

  @override
  CollectionBlocType getBloc() {
    return CollectionEditorBloc(repository: getEditorRepository());
  }

  @override
  EditorRepository<cstate.Collection> getEditorRepository() {
    return CollectionEditorRepository();
  }
}
