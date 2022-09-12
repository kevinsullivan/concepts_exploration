import 'package:test/test.dart';
import 'package:contributingfactorgen/contributingfactorgen.dart';


/// tests for ContributingFactorApi
void main() {
  final instance = Contributingfactorgen().getContributingFactorApi();

  group(ContributingFactorApi, () {
    // Get the contributing factor's category
    //
    // Get the contributing factor's category 
    //
    //Future<Category> category(String contributingFactor) async
    test('test category', () async {
      // TODO
    });

    // CORS category support
    //
    // Enable CORS by returning correct headers 
    //
    //Future categoryInsert() async
    test('test categoryInsert', () async {
      // TODO
    });

    // Get the contributing factor's description
    //
    // Get the contributing factor's description 
    //
    //Future<String> description(String contributingFactor) async
    test('test description', () async {
      // TODO
    });

    // CORS description support
    //
    // Enable CORS by returning correct headers 
    //
    //Future descriptionInsert() async
    test('test descriptionInsert', () async {
      // TODO
    });

  });
}
