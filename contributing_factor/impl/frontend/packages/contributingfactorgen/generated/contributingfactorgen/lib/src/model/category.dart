//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'category.g.dart';

class Category extends EnumClass {

  @BuiltValueEnumConst(wireName: r'patient')
  static const Category patient = _$patient;
  @BuiltValueEnumConst(wireName: r'system')
  static const Category system = _$system;
  @BuiltValueEnumConst(wireName: r'team')
  static const Category team = _$team;

  static Serializer<Category> get serializer => _$categorySerializer;

  const Category._(String name): super(name);

  static BuiltSet<Category> get values => _$values;
  static Category valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class CategoryMixin = Object with _$CategoryMixin;

