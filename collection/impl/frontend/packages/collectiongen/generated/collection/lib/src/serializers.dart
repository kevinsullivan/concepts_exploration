//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_import

import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:collectiongen/src/date_serializer.dart';
import 'package:collectiongen/src/model/date.dart';

import 'package:collectiongen/src/model/collection.dart';
import 'package:collectiongen/src/model/collection_bool.dart';
import 'package:collectiongen/src/model/collection_int.dart';
import 'package:collectiongen/src/model/collection_item_pair.dart';

part 'serializers.g.dart';

@SerializersFor([
  Collection,
  CollectionBool,
  CollectionInt,
  CollectionItemPair,
])
Serializers serializers = (_$serializers.toBuilder()
      ..add(const DateSerializer())
      ..add(Iso8601DateTimeSerializer()))
    .build();

Serializers standardSerializers =
    (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
