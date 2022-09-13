import 'package:concept/concept/view/uirepr/uirepresentation.dart';
import 'package:contributingfactor/contributingfactor/collection_app.dart';
import 'package:contributingfactor/contributingfactor/view/contributing_factor_widget.dart';
import 'package:contributingfactorgen/contributingfactorgen.dart' as gen;
import 'bool_widget.dart';
import 'int_widget.dart';

class UIRepresentationFactory {
  static UIRepresentation<T> construct<T>() {
    if (T == int) {
      return const IntUIRepresentation() as UIRepresentation<T>;
    } else if (T == bool) {
      return const BoolUIRepresentation() as UIRepresentation<T>;
    } else if (T == gen.ContributingFactor) {
      return ContributingFactorRepresentation() as UIRepresentation<T>;
    }
    throw Error();
  }

  static UIRepresentation<T> constructFromT<T>(T t) {
    if (t is int) {
      return IntUIRepresentation(val: t) as UIRepresentation<T>;
    } else if (t is bool) {
      return BoolUIRepresentation(val: t) as UIRepresentation<T>;
    } else if (t is gen.ContributingFactor) {
      return ContributingFactorRepresentation.from(cf: t)
          as UIRepresentation<T>;
    }
    throw Error();
  }
}
