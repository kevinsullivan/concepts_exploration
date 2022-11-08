import 'package:bloc/bloc.dart';
import 'package:intgen/intgen.dart';
import 'package:intapp/int/int_repository.dart';

part 'int_state.dart';
part 'int_event.dart';

class IntBloc extends Bloc<IntEvent, IntState> {
  IntRepository repository;

  int active = 0;

  IntBloc(this.repository) : super(IntGetState(val: 0)) {
    on<Get>(_get);
    on<Set>(_set);
  }

  void _get(Get event, Emitter<IntState> emit) async {
    active = (await repository.get()).value!;

    emit(IntGetState(val: active));
  }

  void _set(Set event, Emitter<IntState> emit) async {
    final value = Int((b) => b.value = event.val);

    await repository.set(value);
  }
}
