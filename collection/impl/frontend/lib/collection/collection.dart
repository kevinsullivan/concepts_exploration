import 'package:concept/concept/action_transformer.dart';
import 'package:concept/concept/concept.dart';
import 'package:concept/concept/repository.dart';
import 'package:concept/concept/transformer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collectiongen/collectiongen.dart' as gen;

import '../collection/bloc/collection_bloc.dart';
import 'collection_repository.dart';
import '../collection/view/collection_layout.dart';

class Collection extends Concept {
  @override
  Bloc<I, O> bloc<I, O>(Repository repository) {
    // TODO: implement bloc
    throw UnimplementedError();
  }

  @override
  Repository repository<I, O>(Transformer<I, O> transformer) {
    // TODO: implement repository
    throw UnimplementedError();
  }

  @override
  Map<String, ActionTransformer> transformers() {
    return {
      "insert": InsertTransformers()
    };
  }
}

class InsertTransformers extends ActionTransformer {
  @override
  Transformer<I, O> blocTransformer<I, O>() {
    // TODO: implement blocTransformer
    throw UnimplementedError();
  }

  @override
  Transformer<I, int> repositoryTransformer<I, int>() {
    // TODO: implement repositoryTransformer
    throw UnimplementedError();
  }

  @override
  Transformer<I, Widget> widgetTransformer<I>() {
    // TODO: implement widgetTransformer
    throw UnimplementedError();
  }
}
