part of 'collection_bloc.dart';

class CollectionState {}

class CollectionInitalState extends CollectionState {
  late gen.Collection initial;

  CollectionInitalState() {
    final builder = gen.CollectionBuilder();
    builder.value = ListBuilder<int>([]);
    initial = builder.build();
  }
}

class CollectionUpdateState extends CollectionState {
  final gen.Collection collectionRepresentation;

  CollectionUpdateState({required this.collectionRepresentation});
}

class IsNotMemberState extends CollectionState {}

class IsMemberState implements CollectionState {}
