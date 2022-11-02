import 'package:openapi_generator_annotations/openapi_generator_annotations.dart';

const spec = '../api.yaml';

@Openapi(
    additionalProperties: AdditionalProperties(pubName: 'jint'),
    inputSpecFile: spec,
    generatorName: Generator.dio,
    outputDirectory: 'generated/jint')
class CollectionConfig extends OpenapiGeneratorConfig {}
