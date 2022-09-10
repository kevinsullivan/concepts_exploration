import 'package:flutter/material.dart';


// widgets have to parametrized by other widgets / ui reprs.
// parametric polymorhpism has to happen at each layers representation.
// ui reprs can be serialized
// ui reprs need inits
part 'int_widget.dart';
part 'bool_widget.dart';


// T is bloc parametrization
abstract class UIRepresentation<T> implements StatefulWidget {
  // Transformation from UIRepresentation to Bloc Representation.
  T transform();

  factory UIRepresentation() {
    if (T == int) {
      return const IntUIRepresentation() as UIRepresentation<T>;
    } else if(T == bool) {
      return const BoolUIRepresentation() as UIRepresentation<T>;
    }
    throw Error();
  }

  factory UIRepresentation.fromT(T t) {
    if (t is int) {
      return IntUIRepresentation(val: t) as UIRepresentation<T>;
    } else if(t is bool) {
      return BoolUIRepresentation(val: t) as UIRepresentation<T>;
    }
    throw Error();
  }
}