//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'collection_bool.g.dart';

/// CollectionBool
///
/// Properties:
/// * [value] 
abstract class CollectionBool implements Built<CollectionBool, CollectionBoolBuilder> {
    @BuiltValueField(wireName: r'value')
    BuiltList<bool>? get value;

    CollectionBool._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(CollectionBoolBuilder b) => b;

    factory CollectionBool([void updates(CollectionBoolBuilder b)]) = _$CollectionBool;

    @BuiltValueSerializer(custom: true)
    static Serializer<CollectionBool> get serializer => _$CollectionBoolSerializer();
}

class _$CollectionBoolSerializer implements StructuredSerializer<CollectionBool> {
    @override
    final Iterable<Type> types = const [CollectionBool, _$CollectionBool];

    @override
    final String wireName = r'CollectionBool';

    @override
    Iterable<Object?> serialize(Serializers serializers, CollectionBool object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        if (object.value != null) {
            result
                ..add(r'value')
                ..add(serializers.serialize(object.value,
                    specifiedType: const FullType(BuiltList, [FullType(bool)])));
        }
        return result;
    }

    @override
    CollectionBool deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = CollectionBoolBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'value':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(BuiltList, [FullType(bool)])) as BuiltList<bool>;
                    result.value.replace(valueDes);
                    break;
            }
        }
        return result.build();
    }
}

