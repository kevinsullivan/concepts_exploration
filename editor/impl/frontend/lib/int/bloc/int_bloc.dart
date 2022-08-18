import 'package:editorsite/editor/bloc/editor_event.dart';

import '../../editor/editor_repository.dart';

import 'package:intapi/src/model/int.dart' as int_state;

import 'package:bloc/bloc.dart';

// TODO: Come back and reconsider use of "part" and "part of"

/*
Take events in response to UI clicks and return states
*/

class IntBloc extends Bloc<EditorEvent, int_state.Int> {
  EditorRepository repository;

  IntBloc({required this.repository})
      : super(int_state.Int((b) => b.value = 0)) {
    on<Get>(_get);
    on<Set>(_set);
  }

  void _get(Get event, Emitter<int_state.Int> emit) async {
    emit(await repository.get());
  }

  void _set(Set event, Emitter<int_state.Int> emit) async {
    repository.set(event.val);
  }
}
