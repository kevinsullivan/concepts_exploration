import "bloc/int_event.dart";
import "bloc/int_bloc.dart";

import "package:intapi/src/model/int.dart" as int_state;

class ViewProxy_int {
  // int state.
  late int_state.Int state;
  final IntBloc intbloc;

  ViewProxy_int({required this.intbloc}) {
    final builder = int_state.IntBuilder();
    builder.value = 0;
    state = builder.build();
  }

  ViewProxy_int.fromState({required this.intbloc, required this.state});

  // NB: We've broken the isomorphism with the spec.
  void get() {
    intbloc.add(Get());
  }

  void set(int val) {
    intbloc.add(Set(val: val));
  }
}
