import 'package:openapi_generator_annotations/openapi_generator_annotations.dart';

const spec = '../../../backend/templates/openapi.yaml';

@Openapi(
    additionalProperties: AdditionalProperties(pubName: 'intgen'),
    inputSpecFile: spec,
    generatorName: Generator.dio,
    outputDirectory: 'generated/int')
class CollectionConfig extends OpenapiGeneratorConfig {}
