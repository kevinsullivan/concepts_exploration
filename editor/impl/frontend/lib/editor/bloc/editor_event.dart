class EditorEvent<T> {}

class Get<T> extends EditorEvent<T> {}

class Set<T> extends EditorEvent<T> {
  final T val;

  Set({required this.val});
}
