import 'package:built_collection/built_collection.dart';
import 'package:collectiongen/collectiongen.dart' as gen;
import 'package:bloc/bloc.dart';
import 'package:collectionsite/collection/collection_repository.dart';
import 'package:built_value/json_object.dart';

part 'collection_state.dart';
part 'collection_event.dart';

class CollectionBloc extends Bloc<CollectionEvent, CollectionState> {
  CollectionRepository repository;

  gen.Collection active = CollectionInitalState().initial;

  CollectionBloc(this.repository) : super(CollectionInitalState()) {
    on<Init>(_init);
    on<Insert>(_insert);
    on<Remove>(_remove);
    on<Member>(_member);
  }

  void _init(Init event, Emitter<CollectionState> emit) async {
    final repr = await repository.init();
    active = repr;
    emit(CollectionUpdateState(collectionRepresentation: repr));
  }

  void _insert(Insert event, Emitter<CollectionState> emit) async {
    final cipBuilder = gen.CollectionItemPairBuilder();
    cipBuilder.item = JsonObject(event.toInsert);
    final cBuilder = gen.CollectionBuilder();
    cBuilder.value = active.value!.toBuilder();

    cipBuilder.collection = cBuilder;

    final pair = cipBuilder.build();

    final repr = await repository.insert(pair);
    active = repr;
    emit(CollectionUpdateState(collectionRepresentation: repr));
  }

  void _remove(Remove event, Emitter<CollectionState> emit) async {
    final cipBuilder = gen.CollectionItemPairBuilder();
    cipBuilder.item = JsonObject(event.toRemove);
    final cBuilder = gen.CollectionBuilder();
    cBuilder.value = active.value!.toBuilder();

    cipBuilder.collection = cBuilder;

    final pair = cipBuilder.build();

    final repr = await repository.remove(pair);
    active = repr;

    emit(CollectionUpdateState(collectionRepresentation: repr));
  }

  void _member(Member event, Emitter<CollectionState> emit) async {
    final cipBuilder = gen.CollectionItemPairBuilder();
    cipBuilder.item = JsonObject(event.possibleMember);

    final cBuilder = gen.CollectionBuilder();
    cBuilder.value = active.value!.toBuilder();

    cipBuilder.collection = cBuilder;

    final pair = cipBuilder.build();

    final isMember = await repository.member(pair);

    if (isMember) {
      emit(IsMemberState());
    } else {
      emit(IsNotMemberState());
    }
  }
}
