import "package:intapi/src/model/int.dart" as int_state;
import "bloc/int_event.dart";
import "bloc/int_bloc.dart";

// NB: This class is a reduced image of our Int concept for particular use by
// gui widgets, thereby providing a proxy interface to the underlying implementation
// of the Int concept.
class GetSet_ViewProxy_int {
  // int state.
  late int_state.Int state; // Generated from Open API schema
  final IntBloc intbloc; // Handwritten, in frontend/lib/int/bloc

  // Construct UI proxy handing it a bloc to talk to
  GetSet_ViewProxy_int({required this.intbloc}) {
    final builder = int_state.IntBuilder();
    builder.value = 0;
    state = builder.build();
  }

  // Same here, but initialize with instance of generated "int" file
  GetSet_ViewProxy_int.fromState({required this.intbloc, required this.state});

  /* The rest are operations that implement the actions of the
  GetSet concept, namely by delegating to correspond operations
  of the bloc.
  */
  void get() {
    intbloc.add(Get());
  }

  void set(int val) {
    intbloc.add(Set(val: val));
  }
}
