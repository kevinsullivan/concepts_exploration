import 'package:test/test.dart';
import 'package:collectiongen/collectiongen.dart';


/// tests for CollectionApi
void main() {
  final instance = Collectiongen().getCollectionApi();

  group(CollectionApi, () {
    // initialize a collection
    //
    // initialize a collection 
    //
    //Future<Collection> init(String bucket, String prefix) async
    test('test init', () async {
      // TODO
    });

    // insert an item into the collection
    //
    // insert an item into the collection 
    //
    //Future<Collection> insert(String bucket, String prefix, { String contentType, CollectionItemPair collectionItemPair }) async
    test('test insert', () async {
      // TODO
    });

    // Boolean-returning membership predicate function
    //
    // Boolean-returning membership predicate function 
    //
    //Future<bool> member(String bucket, String prefix, { String contentType, CollectionItemPair collectionItemPair }) async
    test('test member', () async {
      // TODO
    });

    // CORS init support
    //
    // Enable CORS by returning correct headers 
    //
    //Future optionsInit() async
    test('test optionsInit', () async {
      // TODO
    });

    // CORS insert support
    //
    // Enable CORS by returning correct headers 
    //
    //Future optionsInsert() async
    test('test optionsInsert', () async {
      // TODO
    });

    // CORS member support
    //
    // Enable CORS by returning correct headers 
    //
    //Future optionsMember() async
    test('test optionsMember', () async {
      // TODO
    });

    // CORS remove support
    //
    // Enable CORS by returning correct headers 
    //
    //Future optionsRemove() async
    test('test optionsRemove', () async {
      // TODO
    });

    // remove an item from the collection
    //
    // remove an item from the collection 
    //
    //Future<Collection> remove(String bucket, String prefix, { String contentType, CollectionItemPair collectionItemPair }) async
    test('test remove', () async {
      // TODO
    });

  });
}
