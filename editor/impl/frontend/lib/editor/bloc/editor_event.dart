class EditorEvent<T> {}

class Get<T> extends EditorEvent<T> {}

class Create<T> extends EditorEvent<T> {
  final T val;

  Create({required this.val});
}
