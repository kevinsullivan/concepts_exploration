import 'package:intapi/intapi.dart';
import 'package:intapi/src/api.dart';
import 'package:intapi/src/model/int.dart' as int_state;

abstract class EditorRepository<T> {
  Future<T> get();
  Future<void> set(T arg);
}
