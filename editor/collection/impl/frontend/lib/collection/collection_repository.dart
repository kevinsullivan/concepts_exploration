import 'package:collectionapi/collectionapi.dart';
import 'package:collectionapi/src/model/collection.dart' as cstate;
import 'package:editorsite/editor/editor_repository.dart';

class CollectionEditorRepository extends EditorRepository<cstate.Collection> {
  final api = Collectionapi(
      basePathOverride:
          'https://xlfof7zr7g.execute-api.us-east-1.amazonaws.com/v1');

  @override
  Future<cstate.Collection> get() async {
    final response = api.getCollectionApi().callGet();
    final responseState = (await response).data;
    return responseState!;
  }

  @override
  Future<void> set(cstate.Collection arg) async {
    final response = await api.getCollectionApi().callSet(collection: arg);
  }
}
