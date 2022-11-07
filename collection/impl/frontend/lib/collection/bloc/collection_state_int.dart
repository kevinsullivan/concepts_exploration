part of 'collection_bloc.dart';

class CollectionStateInt {}

class CollectionInitalStateInt extends CollectionStateInt {
  late gen.CollectionInt initial;

  CollectionInitalStateInt() {
    final builder = gen.CollectionIntBuilder();
    builder.value = ListBuilder([]);
    initial = builder.build();
  }
}

class CollectionUpdateStateInt extends CollectionStateInt {
  final gen.CollectionInt collectionRepresentation;

  CollectionUpdateStateInt({required this.collectionRepresentation});
}

class IsNotMemberStateInt extends CollectionStateInt  {}

class IsMemberStateInt  implements CollectionStateInt  {}
