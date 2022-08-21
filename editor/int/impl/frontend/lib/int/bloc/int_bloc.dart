import '../int_editor.dart';
import 'package:editorsite/editor/bloc/editor_event.dart';
import 'package:editorsite/editor/editor_repository.dart';
import 'package:intapi/src/model/int.dart' as int_state;
import 'package:bloc/bloc.dart';

class IntEditorBloc extends IntBlocType {
  EditorRepository repository;

  IntEditorBloc({required this.repository})
      : super(int_state.Int((b) => b.value = 0)) {
    on<Get>(_get);
    on<Create>(_set);
  }

  void _get(Get event, Emitter<int_state.Int> emit) async {
    emit(await repository.get());
  }

  void _set(Create event, Emitter<int_state.Int> emit) async {
    repository.create(event.val);
  }
}
