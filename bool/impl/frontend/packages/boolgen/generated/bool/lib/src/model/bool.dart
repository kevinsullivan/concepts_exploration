//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bool.g.dart';

/// Bool
///
/// Properties:
/// * [value] 
abstract class Bool implements Built<Bool, BoolBuilder> {
    @BuiltValueField(wireName: r'value')
    bool? get value;

    Bool._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(BoolBuilder b) => b;

    factory Bool([void updates(BoolBuilder b)]) = _$Bool;

    @BuiltValueSerializer(custom: true)
    static Serializer<Bool> get serializer => _$BoolSerializer();
}

class _$BoolSerializer implements StructuredSerializer<Bool> {
    @override
    final Iterable<Type> types = const [Bool, _$Bool];

    @override
    final String wireName = r'Bool';

    @override
    Iterable<Object?> serialize(Serializers serializers, Bool object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        if (object.value != null) {
            result
                ..add(r'value')
                ..add(serializers.serialize(object.value,
                    specifiedType: const FullType(bool)));
        }
        return result;
    }

    @override
    Bool deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = BoolBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'value':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(bool)) as bool;
                    result.value = valueDes;
                    break;
            }
        }
        return result.build();
    }
}

