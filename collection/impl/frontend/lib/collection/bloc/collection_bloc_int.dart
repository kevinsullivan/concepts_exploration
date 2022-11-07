part of 'collection_bloc.dart';

// Collection Bloc Specialized to Int.

class CollectionBlocInt extends Bloc<CollectionEvent<int>, CollectionStateInt> {
  CollectionRepository repository;

  gen.CollectionInt active = CollectionInitalStateInt().initial;

  CollectionBlocInt(this.repository) : super(CollectionInitalStateInt()) {
    on<Init<int>>(_init);
    on<Insert<int>>(_insert);
    on<Remove<int>>(_remove);
    on<Member<int>>(_member);
  }

  void _init(Init<int> event, Emitter<CollectionStateInt> emit) async {
    final repr = await repository.init();
    active = repr;
    emit(CollectionUpdateStateInt(collectionRepresentation: repr));
  }

  void _insert(Insert<int> event, Emitter<CollectionStateInt> emit) async {
    final cipBuilder = gen.CollectionItemPairIntBuilder();
    cipBuilder.item = event.toInsert;
    final cBuilder = gen.CollectionIntBuilder();
    cBuilder.value = active.value!.toBuilder();
    cipBuilder.collection = cBuilder;
    final pair = cipBuilder.build();

    final repr = await repository.insert(pair);
    active = repr;
    emit(CollectionUpdateStateInt(collectionRepresentation: repr));
  }

  void _remove(Remove<int> event, Emitter<CollectionStateInt> emit) async {
    final cipBuilder = gen.CollectionItemPairIntBuilder();
    cipBuilder.item = event.toRemove;
    final cBuilder = gen.CollectionIntBuilder();
    cBuilder.value = active.value!.toBuilder();
    cipBuilder.collection = cBuilder;
    final pair = cipBuilder.build();

    final repr = await repository.remove(pair);
    active = repr;

    emit(CollectionUpdateStateInt(collectionRepresentation: repr));
  }

  void _member(Member<int> event, Emitter<CollectionStateInt> emit) async {
    final cipBuilder = gen.CollectionItemPairIntBuilder();
    cipBuilder.item = event.possibleMember;
    final cBuilder = gen.CollectionIntBuilder();
    cBuilder.value = active.value!.toBuilder();
    cipBuilder.collection = cBuilder;
    final pair = cipBuilder.build();

    final isMember = await repository.member(pair);

    if (isMember) {
      emit(IsMemberStateInt());
    } else {
      emit(IsNotMemberStateInt());
    }
  }
}
