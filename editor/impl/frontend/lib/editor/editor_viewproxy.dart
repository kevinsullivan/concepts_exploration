import 'package:bloc/bloc.dart';

import 'bloc/editor_event.dart';

class EditorViewProxy<T> {
  late T state;
  final Bloc bloc;

  EditorViewProxy({required this.bloc});
  EditorViewProxy.fromState({required this.bloc, required this.state});

  void get() {
    bloc.add(Get<T>());
  }

  void set(T val) {
    bloc.add(Set<T>(val: val));
  }
}
