//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'j_int.g.dart';

/// JInt
///
/// Properties:
/// * [value] 
abstract class JInt implements Built<JInt, JIntBuilder> {
    @BuiltValueField(wireName: r'value')
    int? get value;

    JInt._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(JIntBuilder b) => b;

    factory JInt([void updates(JIntBuilder b)]) = _$JInt;

    @BuiltValueSerializer(custom: true)
    static Serializer<JInt> get serializer => _$JIntSerializer();
}

class _$JIntSerializer implements StructuredSerializer<JInt> {
    @override
    final Iterable<Type> types = const [JInt, _$JInt];

    @override
    final String wireName = r'JInt';

    @override
    Iterable<Object?> serialize(Serializers serializers, JInt object,
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
    JInt deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = JIntBuilder();

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

