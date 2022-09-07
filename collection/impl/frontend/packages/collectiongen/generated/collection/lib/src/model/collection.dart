//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'collection.g.dart';

/// Collection
///
/// Properties:
/// * [value] 
abstract class Collection implements Built<Collection, CollectionBuilder> {
    @BuiltValueField(wireName: r'value')
    BuiltList<JsonObject?>? get value;

    Collection._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(CollectionBuilder b) => b;

    factory Collection([void updates(CollectionBuilder b)]) = _$Collection;

    @BuiltValueSerializer(custom: true)
    static Serializer<Collection> get serializer => _$CollectionSerializer();
}

class _$CollectionSerializer implements StructuredSerializer<Collection> {
    @override
    final Iterable<Type> types = const [Collection, _$Collection];

    @override
    final String wireName = r'Collection';

    @override
    Iterable<Object?> serialize(Serializers serializers, Collection object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        if (object.value != null) {
            result
                ..add(r'value')
                ..add(serializers.serialize(object.value,
                    specifiedType: const FullType(BuiltList, [FullType.nullable(JsonObject)])));
        }
        return result;
    }

    @override
    Collection deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = CollectionBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'value':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(BuiltList, [FullType.nullable(JsonObject)])) as BuiltList<JsonObject?>;
                    result.value.replace(valueDes);
                    break;
            }
        }
        return result.build();
    }
}

