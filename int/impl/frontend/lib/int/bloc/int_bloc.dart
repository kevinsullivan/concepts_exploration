import 'package:bloc/bloc.dart';
import 'package:intsite/int/int_repository.dart';
import 'int_event.dart';
import 'package:intapi/src/model/int.dart' as int_state;
import '../Int.dart';

// TODO: Come back and reconsider use of "part" and "part of"

/*
Take events in response to UI clicks and return states
*/

class IntBloc extends Bloc<IntEvent, int_state.Int> {
  IntRepository repository;

  IntBloc({required this.repository})
      : super(int_state.Int((b) => b.value = 0)) {
    on<Get>(_get);
    on<Set>(_set);
  }

  void _get(Get event, Emitter<int_state.Int> emit) async {
    emit(await repository.get());
  }

  void _set(Set event, Emitter<int_state.Int> emit) async {
    final builder = int_state.IntBuilder();
    builder.value = event.val;
    final intstate = builder.build();

    repository.set(intstate);
  }
}
