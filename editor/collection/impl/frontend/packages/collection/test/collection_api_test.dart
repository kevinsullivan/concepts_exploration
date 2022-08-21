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
      // TODO
    });

    // insert an object into the collection
    //
    // insert an object into the collection 
    //
    //Future<String> create({ Collection collection }) async
    test('test create', () async {
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
