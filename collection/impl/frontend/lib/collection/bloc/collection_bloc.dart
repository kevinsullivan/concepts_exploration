import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:collectiongen/collectiongen.dart' as gen;
import 'package:bloc/bloc.dart';
import 'package:collectionsite/collection/collection_repository.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:contributingfactorgen/contributingfactorgen.dart' as cfgen;

part 'collection_state.dart';
part 'collection_event.dart';

part 'collection_state_int.dart';
part 'collection_bloc_int.dart';


//// bloc needs to be able to create T ui to pass up
//// bloc needs to be able to send T down
//
//// state should not be managed in ui ever. It is just visuals of the
//// actual stuff appening here.
//
//// all my collection items are here and have an interface tat I need
//
//class CollectionBloc<T> extends Bloc<CollectionEvent<T>, CollectionState> {
//  CollectionRepository repository;
//
//  // This bloc seems to be th most accurate flavor of our concept..
//  //  it seems like wat we need is for our collection bloc to emit T widgets? so
//  // is can display the concepts? But that seems odd.
//  // Perhaps it instead emits some repr that the widge view can use to construct
//
//  gen.CollectionInt active = CollectionInitalState().initial;
//
//  CollectionBloc(this.repository) : super(CollectionInitalState()) {
//    on<Init<T>>(_init);
//    on<Insert<T>>(_insert);
//    on<Remove<T>>(_remove);
//    on<Member<T>>(_member);
//  }
//
//  void _init(Init<T> event, Emitter<CollectionState> emit) async {
//    final repr = await repository.init();
//    active = repr;
//    emit(CollectionUpdateState(collectionRepresentation: repr));
//  }
//
//  // void _begin_insert -> emit ui representation
//  // void _complete_insert -> do actual operation
//  // T must have a default constructor so I can create it in the bloc layer
//  //  -- having a ui version / widget version of a concept leads to bad
//  // design since it is best practice to separate business logic and view
//  //  really should be composing at bloc / business logic level
//  // From our bloc representations of T, and activeCollection, construct
//  // a repository representation (collectionItemPair).
//
//  void _insert(Insert<T> event, Emitter<CollectionState> emit) async {
//    if (event.toInsert is cfgen.ContributingFactor) {
//      await _cf_insert(event, emit);
//      return;
//    }
//
//    final cipBuilder = gen.CollectionItemPairBuilder();
//    cipBuilder.item = JsonObject(event.toInsert);
//    final cBuilder = gen.CollectionBuilder();
//    cBuilder.value = active.value!.toBuilder();
//
//    cipBuilder.collection = cBuilder;
//
//    final pair = cipBuilder.build();
//
//    final repr = await repository.insert(pair);
//    active = repr;
//    emit(CollectionUpdateState(collectionRepresentation: repr));
//  }
//
//  // Hack for now.
//  FutureOr<void> _cf_insert(
//      Insert<T> event, Emitter<CollectionState> emit) async {
//    final cipBuilder = gen.CollectionItemPairBuilder();
//    cipBuilder.item =
//        JsonObject((cfgen.serializers.serialize(event.toInsert) as List)[1]);
//    final cBuilder = gen.CollectionBuilder();
//    cBuilder.value = active.value!.toBuilder();
//
//    cipBuilder.collection = cBuilder;
//
//    final pair = cipBuilder.build();
//
//    final repr = await repository.insert(pair);
//    active = repr;
//
//    //final collectionBuilder = gen.CollectionBuilder();
//    //var x = repr.value!.map((p0) => p0!.asString).map((e) => cfgen.serializers
//    //    .deserializeWith(cfgen.ContributingFactor.serializer, e));
//    //collectionBuilder.value = ListBuilder(x);
//    //active = collectionBuilder.build();
//
//    emit(CollectionUpdateState(collectionRepresentation: repr));
//  }
//
//  void _remove(Remove<T> event, Emitter<CollectionState> emit) async {
//    final cipBuilder = gen.CollectionItemPairBuilder();
//    try {
//      cipBuilder.item = JsonObject(event.toRemove);
//    } on ArgumentError {
//      if (event.toRemove is cfgen.ContributingFactor) {
//        cipBuilder.item = JsonObject(
//            (cfgen.serializers.serialize(event.toRemove) as List)[1]);
//      } else {
//        rethrow;
//      }
//    }
//    final cBuilder = gen.CollectionBuilder();
//    cBuilder.value = active.value!.toBuilder();
//
//    cipBuilder.collection = cBuilder;
//
//    final pair = cipBuilder.build();
//
//    final repr = await repository.remove(pair);
//    active = repr;
//
//    emit(CollectionUpdateState(collectionRepresentation: repr));
//  }
//
//  void _member(Member<T> event, Emitter<CollectionState> emit) async {
//    final cipBuilder = gen.CollectionItemPairBuilder();
//    try {
//      cipBuilder.item = JsonObject(event.possibleMember);
//    } on ArgumentError {
//      if (event.possibleMember is cfgen.ContributingFactor) {
//        cipBuilder.item = JsonObject(
//            (cfgen.serializers.serialize(event.possibleMember) as List)[1]);
//      } else {
//        rethrow;
//      }
//    }
//
//    final cBuilder = gen.CollectionBuilder();
//    cBuilder.value = active.value!.toBuilder();
//
//    cipBuilder.collection = cBuilder;
//
//    final pair = cipBuilder.build();
//
//    final isMember = await repository.member(pair);
//
//    if (isMember) {
//      emit(IsMemberState());
//    } else {
//      emit(IsNotMemberState());
//    }
//  }
//}
//