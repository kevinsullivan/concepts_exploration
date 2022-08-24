import 'package:editorsite/editor/bloc/editor_event.dart';
import 'package:editorsite/editor/editor_repository.dart';

import 'package:collectionapi/src/model/collection.dart' as cstate;

import 'package:bloc/bloc.dart';

import '../collection_editor.dart';
import 'package:built_value/json_object.dart';

class CollectionEditorBloc extends CollectionBlocType {
  EditorRepository repository;

  CollectionEditorBloc({required this.repository})
      : super(cstate.Collection((b) => b.value.add(JsonObject([])))) {
    on<Get>(_get);
    on<Create>(_set);
  }

  void _get(Get event, Emitter<cstate.Collection> emit) async {
    emit(await repository.get());
  }

  void _set(Create event, Emitter<cstate.Collection> emit) async {
    repository.create(event.val);
  }
}
