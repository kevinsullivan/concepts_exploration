import 'package:concept/concept/transformer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'repository.dart';

abstract class ActionTransformer {
  Transformer<I, Widget> widgetTransformer<I>();
  Transformer<I, O> repositoryTransformer<I, O>();
  Transformer<I, O> blocTransformer<I, O>();
}
