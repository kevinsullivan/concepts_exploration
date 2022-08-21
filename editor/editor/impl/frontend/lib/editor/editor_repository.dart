abstract class EditorRepository<T> {
  Future<T> get();
  Future<void> create(T arg);
}
