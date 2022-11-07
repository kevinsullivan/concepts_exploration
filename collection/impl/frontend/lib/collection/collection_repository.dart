import 'package:collectiongen/collectiongen.dart' as gen;
import 'package:concept/concept/repository.dart';
import 'package:concept/concept/transformer.dart';


// Specialized For Int.

const basePath = 'https://dry7fr8g0h.execute-api.us-east-1.amazonaws.com/v1';

class CollectionRepository<Int> extends Repository {
  final generator = gen.Collectiongen(basePathOverride: basePath);

  CollectionRepository() {
    generator.dio.options.connectTimeout = 30 * 1000;
    generator.dio.options.receiveTimeout = 30 * 1000;
    generator.dio.options.sendTimeout = 30 * 1000;
  }

  Future<gen.CollectionInt> init() async {
    Map<String, String> headers = {'t': 'int'};
    final response = await generator.getCollectionApi().init(headers: headers);
    final responseState = response.data;
    return responseState!;
  }

  Future<gen.CollectionInt> insert(gen.CollectionItemPairInt arg) async {
    Map<String, String> headers = {'t': 'int'};
    final response = generator
        .getCollectionApi()
        .insert(collectionItemPairInt: arg, headers: headers);
    final responseState = (await response).data;
    return responseState!;
  }

  Future<gen.CollectionInt> remove(gen.CollectionItemPairInt arg) async {
    Map<String, String> headers = {'t': 'int'};
    final response = generator
        .getCollectionApi()
        .remove(collectionItemPairInt: arg, headers: headers);
    final responseState = (await response).data;
    return responseState!;
  }

  Future<bool> member(gen.CollectionItemPairInt arg) async {
    Map<String, String> headers = {'t': 'int'};
    final response = generator
        .getCollectionApi()
        .member(collectionItemPairInt: arg, headers: headers);
    final responseState = (await response).data;
    return responseState!;
  }
}
