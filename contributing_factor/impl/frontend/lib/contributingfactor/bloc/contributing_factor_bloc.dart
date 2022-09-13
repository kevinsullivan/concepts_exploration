import 'dart:async';

import 'package:contributingfactorgen/contributingfactorgen.dart' as gen;
import 'package:bloc/bloc.dart';

import '../contributing_factor_repository.dart';

part 'contributing_factor_state.dart';
part 'contributing_factor_event.dart';

class ContributingFactorBloc
    extends Bloc<ContributingFactorEvent, ContributingFactorState> {
  ContributingFactorRepository repository;

  gen.ContributingFactor active = ContributingFactorInitalState().initial;

  ContributingFactorBloc(this.repository)
      : super(ContributingFactorInitalState()) {
    on<Category>(_category);
    on<Description>(_description);
  }

  FutureOr<void> _category(
      Category event, Emitter<ContributingFactorState> emit) async {
    final response = await repository.category(event.constributingFactor);
    emit(ContributingFactorCateogryUpdateState(category: response.name));
  }

  FutureOr<void> _description(
      Description event, Emitter<ContributingFactorState> emit) async {
    final response = await repository.description(event.constributingFactor);
    emit(ContributingFactorDescriptionUpdateState(description: response));
  }
}
