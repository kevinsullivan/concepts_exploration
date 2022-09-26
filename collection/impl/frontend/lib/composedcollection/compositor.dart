import 'package:concept/concept/concept.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../collection/bloc/collection_bloc.dart';
import '../collection/collection.dart';
import '../collection/collection_repository.dart';
import '../collection/view/collection_layout.dart';

// the  compositors goal is to figure out how to take the transformation
// of X -> Collection<T> and T -> Int and create X -> Collection<Int>

// anything openapi generats won't be rich enough so leave it bytes.
// a collection of bytes. For paramterization, I need to support partial
// deserialization.. no compsitor gives you te full deserializatin type

// incuding a composed open openapi spec! Once I compose the open api spec
// things get better because I have a rich definition.


// =====
// openapi composition takes the model of T and makes it the type
// of collection.items. Either yaml parser or openapi package here!!!
// Stupid me should have started with this....


// all collection type params come in from compositor
// it is the compositors job to know the input and output type
class CollectionCompositor {
  final Collection collection;
  final Concept tall;

  const CollectionCompositor({required this.collection, required this.tall});

  Widget composeApp() {
    final collectionRepo = collection.repository();

    final collectionBloc = collection.bloc(collectionRepo);
    final trepo = tall.repository();
    final tbloc = tall.bloc(trepo);

    final mbp = MultiBlocProvider(
        providers: [
          BlocProvider<CollectionBloc>(create: (_) => collectionBloc),
          BlocProvider<Bloc>(create: (_) => tbloc)
        ],
        child: Scaffold(
            body: Center(
                child:
                    CollectionLayout<I>(tbuilder: tall.widgetTransformer()))));
    return MaterialApp(title: "Collection", home: mbp);
  }
}
