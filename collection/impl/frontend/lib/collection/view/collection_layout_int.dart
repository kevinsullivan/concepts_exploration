import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'collection_widgets_int.dart';
import 'package:collectiongen/collectiongen.dart' as gen;

class CollectionLayoutInt extends StatelessWidget {

  CollectionLayoutInt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [CollectionViewerInt(), ButtonRow()],
    );
  }
}

class ButtonRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [InitInt(), InsertInt(), RemoveInt()],
    );
  }
}
