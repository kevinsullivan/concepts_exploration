import 'package:bloc/bloc.dart';
import 'package:boolgen/boolgen.dart';
import 'package:boolapp/bool/bool_repository.dart';

part 'bool_state.dart';
part 'bool_event.dart';

class BoolBloc extends Bloc<BoolEvent, BoolState> {
  BoolRepository repository;

  bool active = false;

  BoolBloc(this.repository) : super(BoolGetState(val: false)) {
    on<Get>(_get);
    on<Set>(_set);
  }

  void _get(Get event, Emitter<BoolState> emit) async {
    active = (await repository.get()).value!;

    emit(BoolGetState(val: active));
  }

  void _set(Set event, Emitter<BoolState> emit) async {
    final value = Bool((b) => b.value = event.val);

    await repository.set(value);
  }
}
