import 'package:concept/concept/view/uirepr/uirepresentation.dart';
import 'bool_widget.dart';
import 'int_widget.dart';

class UIRepresentationFactory {

  static UIRepresentation<T> construct<T>() {
    if (T == int) {
      return const IntUIRepresentation() as UIRepresentation<T>;
    } else if(T == bool) {
      return const BoolUIRepresentation() as UIRepresentation<T>;
    }
    throw Error();
  }

  static UIRepresentation<T> constructFromT<T>(T t) {
    if (t is int) {
      return IntUIRepresentation(val: t) as UIRepresentation<T>;
    } else if(t is bool) {
      return BoolUIRepresentation(val: t) as UIRepresentation<T>;
    }
    throw Error();
  }
}