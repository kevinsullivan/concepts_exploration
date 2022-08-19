import 'package:editorsite/editor/editor_repository.dart';
import 'package:intapi/intapi.dart';
import 'package:intapi/src/api.dart';
import 'package:intapi/src/model/int.dart' as int_state;

class IntEditorRepository extends EditorRepository<int_state.Int> {
  Intapi intApi = Intapi(
      basePathOverride:
          'https://v3d3edk9qe.execute-api.us-east-1.amazonaws.com/v1');

  @override
  Future<int_state.Int> get() async {
    final response = intApi.getIntApi().getInt();
    final intStateInbound = (await response).data;
    return intStateInbound!;
  }

  @override
  Future<void> set(int_state.Int arg) async {
    final response = await intApi.getIntApi().setInt(int_: arg);
  }
}
