import 'package:collectionsite/collection/view/collection_homepage.dart';
import 'package:flutter/material.dart';

class CollectionApp extends StatelessWidget {

  const CollectionApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: "Collection", home: CollectionHomepage());
  }
}