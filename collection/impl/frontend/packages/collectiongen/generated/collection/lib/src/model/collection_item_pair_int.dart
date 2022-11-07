//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:collectiongen/src/model/collection_int.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'collection_item_pair_int.g.dart';

/// CollectionItemPairInt
///
/// Properties:
/// * [collection] 
/// * [item] 
abstract class CollectionItemPairInt implements Built<CollectionItemPairInt, CollectionItemPairIntBuilder> {
    @BuiltValueField(wireName: r'collection')
    CollectionInt? get collection;

    @BuiltValueField(wireName: r'item')
    int? get item;

    CollectionItemPairInt._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(CollectionItemPairIntBuilder b) => b;

    factory CollectionItemPairInt([void updates(CollectionItemPairIntBuilder b)]) = _$CollectionItemPairInt;

    @BuiltValueSerializer(custom: true)
    static Serializer<CollectionItemPairInt> get serializer => _$CollectionItemPairIntSerializer();
}

class _$CollectionItemPairIntSerializer implements StructuredSerializer<CollectionItemPairInt> {
    @override
    final Iterable<Type> types = const [CollectionItemPairInt, _$CollectionItemPairInt];

    @override
    final String wireName = r'CollectionItemPairInt';

    @override
    Iterable<Object?> serialize(Serializers serializers, CollectionItemPairInt object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        if (object.collection != null) {
            result
                ..add(r'collection')
                ..add(serializers.serialize(object.collection,
                    specifiedType: const FullType(CollectionInt)));
        }
        if (object.item != null) {
            result
                ..add(r'item')
                ..add(serializers.serialize(object.item,
                    specifiedType: const FullType(int)));
        }
        return result;
    }

    @override
    CollectionItemPairInt deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = CollectionItemPairIntBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'collection':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(CollectionInt)) as CollectionInt;
                    result.collection.replace(valueDes);
                    break;
                case r'item':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(int)) as int;
                    result.item = valueDes;
                    break;
            }
        }
        return result.build();
    }
}

