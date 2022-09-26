import 'package:collectiongen/collectiongen.dart' as gen;
import 'package:concept/concept/repository.dart';
import 'package:concept/concept/transformer.dart';

const basePath = 'https://dry7fr8g0h.execute-api.us-east-1.amazonaws.com/v1';

class CollectionRepository<I, O extends gen.Collection> extends Repository {
  final generator = gen.Collectiongen(basePathOverride: basePath);

  final Transformer<I, O> transfomer;

  CollectionRepository({required this.transfomer}) {
    generator.dio.options.connectTimeout = 30 * 1000;
    generator.dio.options.receiveTimeout = 30 * 1000;
    generator.dio.options.sendTimeout = 30 * 1000;
  }

  Future<gen.Collection> init() async {
    Map<String, String> headers = {'t': I.toString().toLowerCase()};
    final response = await generator.getCollectionApi().init(headers: headers);
    final responseState = response.data;
    transfomer.reverse(response.data);
    return responseState!;
  }

  Future<gen.Collection> insert(gen.CollectionItemPair arg) async {
    Map<String, String> headers = {'t': I.toString().toLowerCase()};
    final response = generator
        .getCollectionApi()
        .insert(collectionItemPair: arg, headers: headers);
    final responseState = (await response).data;
    return responseState!;
  }

  Future<gen.Collection> remove(gen.CollectionItemPair arg) async {
    Map<String, String> headers = {'t': I.toString().toLowerCase()};
    final response = generator
        .getCollectionApi()
        .remove(collectionItemPair: arg, headers: headers);
    final responseState = (await response).data;
    return responseState!;
  }

  Future<bool> member(gen.CollectionItemPair arg) async {
    Map<String, String> headers = {'t': I.toString().toLowerCase()};
    final response = generator
        .getCollectionApi()
        .member(collectionItemPair: arg, headers: headers);
    final responseState = (await response).data;
    return responseState!;
  }
}
