import 'package:contributingfactorgen/contributingfactorgen.dart' as gen;

const basePath = 'https://0ii2889fze.execute-api.us-east-1.amazonaws.com/v1';

class ContributingFactorRepository {
  final generator = gen.Contributingfactorgen(basePathOverride: basePath);

  ContributingFactorRepository() {
    generator.dio.options.connectTimeout = 30 * 1000;
    generator.dio.options.receiveTimeout = 30 * 1000;
    generator.dio.options.sendTimeout = 30 * 1000;
  }

  Future<gen.Category> category(
      gen.ContributingFactor contributingFactor) async {
    final cf = gen.serializers.serializeWith(
        gen.ContributingFactor.serializer, contributingFactor) as String;
    final response =
        generator.getContributingFactorApi().category(contributingFactor: cf);
    final responseState = (await response).data;
    return responseState!;
  }

  Future<String> description(gen.ContributingFactor contributingFactor) async {
    final cf = gen.serializers.serializeWith(
        gen.ContributingFactor.serializer, contributingFactor) as String;
    final response = generator
        .getContributingFactorApi()
        .description(contributingFactor: cf);
    final responseState = (await response).data;
    return responseState!;
  }
}
