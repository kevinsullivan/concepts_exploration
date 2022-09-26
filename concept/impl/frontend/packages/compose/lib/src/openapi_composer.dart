import 'dart:io';

import 'package:yaml/yaml.dart';
import 'package:yaml_edit/yaml_edit.dart';

class OpenApiComposer {
  final YamlEditor editor;

  OpenApiComposer(String base) : editor = YamlEditor(base);

  addRef(String path, String value) {
    if (!path.endsWith('\$ref')) {
      throw Error();
    }

    final toUpdatePath = path.split('/').where((element) => element.isNotEmpty);
    editor.update(toUpdatePath, wrapAsYamlNode(value));
    print(editor.toString());
  }

  @override
  String toString() {
    return editor.toString();
  }
}
