import 'dart:convert';
import 'dart:io';

import 'package:compose/compose.dart';
import 'package:test/test.dart';
import 'package:yaml_edit/yaml_edit.dart';

void main() {
  group('A group of tests', () {
    setUp(() {
      // Additional setup goes here.
    });

    test('First Test', () async {
      final path =
          "/opt/devel/uva/repos/concepts_exploration/collection/impl/backend/sam/Functions/src/main/resources/api.yaml";
      final data = await File(path).readAsString();

      final composer = OpenApiComposer(data);
      final ypath =
          '/components/schemas/Collection/properties/value/items/\$ref';
      composer.addRef(ypath, '#/foo/bar');
    });
  });
}
