import 'package:openapi_generator_annotations/openapi_generator_annotations.dart';

const spec = '../../../backend/templates/openapi.yaml';

@Openapi(
    additionalProperties: AdditionalProperties(pubName: 'boolgen'),
    inputSpecFile: spec,
    generatorName: Generator.dio,
    outputDirectory: 'generated/bool')
class CollectionConfig extends OpenapiGeneratorConfig {}
