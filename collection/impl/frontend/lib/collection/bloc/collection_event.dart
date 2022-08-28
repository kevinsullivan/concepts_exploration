part of 'collection_bloc.dart';

abstract class CollectionEvent<T> {
  const CollectionEvent();
}

class Init<T> extends CollectionEvent<T> {
  Init();
}

class Insert<T> extends CollectionEvent<T> {
  final T toInsert;
  const Insert({required this.toInsert});
}

class Remove<T> extends CollectionEvent<T> {
  final T toRemove;
  const Remove({required this.toRemove});
}

class Member<T> extends CollectionEvent<T> {
  final T possibleMember;
  const Member({required this.possibleMember});
}
