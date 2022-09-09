import 'package:collectionsite/collection/bloc/collection_bloc.dart';
import 'package:collectionsite/collection/collection_repository.dart';
import 'package:collectionsite/collection/view/collection_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CollectionHomepage<T> extends StatelessWidget {
  const CollectionHomepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => CollectionBloc<T>(CollectionRepository<T>()),
        child: Scaffold(body: Center(child: CollectionView<T>())));
  }
}
