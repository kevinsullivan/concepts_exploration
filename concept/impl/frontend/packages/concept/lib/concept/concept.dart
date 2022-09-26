import 'package:concept/concept/action_transformer.dart';
import 'package:concept/concept/transformer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'repository.dart';

typedef WidgetFromStateBuilder<T> = Widget Function(T state);

// composition is really only happening at ui level. T is a state representation
// compositro fills in
// concepts are parameterized by input and output types. it is the compositor that defies tese
// in simple cases, these are not needed.
abstract class Concept {
  //Transformer<I, Widget> widgetTransformer<I>();

  Map<String, ActionTransformer> transformers();
  Repository repository<I, O>(Transformer<I, O> transformer);
  Bloc<I, O> bloc<I, O>(Repository repository);
}
