//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:collectiongen/src/model/collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'collection_item_pair.g.dart';

/// CollectionItemPair
///
/// Properties:
/// * [collection] 
/// * [item] - Can be any value - string, number, boolean, array or object.
abstract class CollectionItemPair implements Built<CollectionItemPair, CollectionItemPairBuilder> {
    @BuiltValueField(wireName: r'collection')
    Collection? get collection;

    /// Can be any value - string, number, boolean, array or object.
    @BuiltValueField(wireName: r'item')
    JsonObject? get item;

    CollectionItemPair._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(CollectionItemPairBuilder b) => b;

    factory CollectionItemPair([void updates(CollectionItemPairBuilder b)]) = _$CollectionItemPair;

    @BuiltValueSerializer(custom: true)
    static Serializer<CollectionItemPair> get serializer => _$CollectionItemPairSerializer();
}

class _$CollectionItemPairSerializer implements StructuredSerializer<CollectionItemPair> {
    @override
    final Iterable<Type> types = const [CollectionItemPair, _$CollectionItemPair];

    @override
    final String wireName = r'CollectionItemPair';

    @override
    Iterable<Object?> serialize(Serializers serializers, CollectionItemPair object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        if (object.collection != null) {
            result
                ..add(r'collection')
                ..add(serializers.serialize(object.collection,
                    specifiedType: const FullType(Collection)));
        }
        if (object.item != null) {
            result
                ..add(r'item')
                ..add(serializers.serialize(object.item,
                    specifiedType: const FullType.nullable(JsonObject)));
        }
        return result;
    }

    @override
    CollectionItemPair deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = CollectionItemPairBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'collection':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(Collection)) as Collection;
                    result.collection.replace(valueDes);
                    break;
                case r'item':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(JsonObject)) as JsonObject?;
                    if (valueDes == null) continue;
                    result.item = valueDes;
                    break;
            }
        }
        return result.build();
    }
}

