import 'package:collectionapi/collectionapi.dart';
import 'package:collectionapi/src/model/collection.dart' as cstate;
import 'package:editorsite/editor/editor_repository.dart';

class CollectionEditorRepository extends EditorRepository<cstate.Collection> {
  // TODO: Move this into a config file.
  final api = Collectionapi(
      basePathOverride:
          'https://xlfof7zr7g.execute-api.us-east-1.amazonaws.com/v1');

  @override
  Future<cstate.Collection> get() async {
    final response = api.getCollectionApi().callGet(
          folder: "jackson-concepts-concepts", // TODO: Move to config.
        );
    final responseState = (await response).data;
    return responseState!;
  }

  @override
  Future<void> create(cstate.Collection arg) async {
    // NB: Still passing around the full collection state...
    final response = await api.getCollectionApi().create(
        folder: "jackson-concepts-concepts", // TODO: Move to config.
        item: DateTime.now().millisecondsSinceEpoch.toString(),
        collection: arg);
    print(DateTime.now().millisecondsSinceEpoch.toString());
    print(response);
  }
}
