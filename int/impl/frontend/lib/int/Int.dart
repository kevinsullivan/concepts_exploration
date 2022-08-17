import "package:intapi/src/model/int.dart" as int_state;
import 'package:intsite/int/int_repository.dart';
import "bloc/int_event.dart";
import "bloc/int_bloc.dart";

// NB: This class is a reduced image of our Int concept for particular use by
// gui widgets, thereby providing a proxy interface to the underlying implementation
// of the Int concept.
class Int {
  // int state.
  late int_state.Int state;
  final IntBloc intbloc;

  Int({required this.intbloc}) {
    final builder = int_state.IntBuilder();
    builder.value = 0;
    state = builder.build();
  }

  Int.fromState({required this.intbloc, required this.state});

  // NB: We've broken the isomorphism with the spec.
  void get() {
    intbloc.add(Get());
  }

  void set(int val) {
    intbloc.add(Set(val: val));
  }
}
