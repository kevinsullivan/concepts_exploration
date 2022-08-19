//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'int.g.dart';

/// Int
///
/// Properties:
/// * [value] 
abstract class Int implements Built<Int, IntBuilder> {
    @BuiltValueField(wireName: r'value')
    int? get value;

    Int._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(IntBuilder b) => b;

    factory Int([void updates(IntBuilder b)]) = _$Int;

    @BuiltValueSerializer(custom: true)
    static Serializer<Int> get serializer => _$IntSerializer();
}

class _$IntSerializer implements StructuredSerializer<Int> {
    @override
    final Iterable<Type> types = const [Int, _$Int];

    @override
    final String wireName = r'Int';

    @override
    Iterable<Object?> serialize(Serializers serializers, Int object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        if (object.value != null) {
            result
                ..add(r'value')
                ..add(serializers.serialize(object.value,
                    specifiedType: const FullType(int)));
        }
        return result;
    }

    @override
    Int deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = IntBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'value':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(int)) as int;
                    result.value = valueDes;
                    break;
            }
        }
        return result.build();
    }
}

