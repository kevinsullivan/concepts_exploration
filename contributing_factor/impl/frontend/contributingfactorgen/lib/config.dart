import 'package:openapi_generator_annotations/openapi_generator_annotations.dart';

const spec = '../../backend/sam/Functions/src/main/resources/api.yaml';

@Openapi(
    additionalProperties:
        AdditionalProperties(pubName: 'contributingfactorgen'),
    inputSpecFile: spec,
    generatorName: Generator.dio,
    outputDirectory: 'generated/contributingfactorgen')
class ContributingFactorConfig extends OpenapiGeneratorConfig {}
