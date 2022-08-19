abstract class EditorRepository<T> {
  Future<T> get();
  Future<void> set(T arg);
}
