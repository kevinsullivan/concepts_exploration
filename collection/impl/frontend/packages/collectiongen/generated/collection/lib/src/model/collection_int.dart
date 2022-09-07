//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'collection_int.g.dart';

/// CollectionInt
///
/// Properties:
/// * [value] 
abstract class CollectionInt implements Built<CollectionInt, CollectionIntBuilder> {
    @BuiltValueField(wireName: r'value')
    BuiltList<int>? get value;

    CollectionInt._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(CollectionIntBuilder b) => b;

    factory CollectionInt([void updates(CollectionIntBuilder b)]) = _$CollectionInt;

    @BuiltValueSerializer(custom: true)
    static Serializer<CollectionInt> get serializer => _$CollectionIntSerializer();
}

class _$CollectionIntSerializer implements StructuredSerializer<CollectionInt> {
    @override
    final Iterable<Type> types = const [CollectionInt, _$CollectionInt];

    @override
    final String wireName = r'CollectionInt';

    @override
    Iterable<Object?> serialize(Serializers serializers, CollectionInt object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        if (object.value != null) {
            result
                ..add(r'value')
                ..add(serializers.serialize(object.value,
                    specifiedType: const FullType(BuiltList, [FullType(int)])));
        }
        return result;
    }

    @override
    CollectionInt deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = CollectionIntBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'value':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(BuiltList, [FullType(int)])) as BuiltList<int>;
                    result.value.replace(valueDes);
                    break;
            }
        }
        return result.build();
    }
}

