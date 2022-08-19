import 'package:test/test.dart';
import 'package:collectionapi/collectionapi.dart';

/// tests for CollectionApi
void main() {
  final instance = Collectionapi().getCollectionApi();

  group(CollectionApi, () {
    // Get Collection
    //
    // Get the collection
    //
    //Future<Collection> callGet() async
    test('test callGet', () async {
      final response = await instance.callGet();
      print(response);
      // TODO
    });

    // Set Collection
    //
    // Set the collection
    //
    //Future<String> callSet({ Collection collection }) async
    test('test callSet', () async {
      // TODO
    });

    // getCollection Cors
    //
    // Enable CORS
    //
    //Future optionsGetCollection() async
    test('test optionsGetCollection', () async {
      // TODO
    });

    // CORS setCollection support
    //
    // Enable CORS by returning correct headers
    //
    //Future optionsSetCollection() async
    test('test optionsSetCollection', () async {
      // TODO
    });
  });
}
