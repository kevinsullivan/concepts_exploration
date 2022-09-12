part of 'contributing_factor_bloc.dart';

class ContributingFactorState {}

class ContributingFactorInitalState extends ContributingFactorState {
  late gen.ContributingFactor initial;
  late String desc;
  late String category;

  ContributingFactorInitalState() {
    initial = gen.ContributingFactor.systemOther;
    desc = "";
    category = "";
  }
}

class ContributingFactorDescriptionUpdateState extends ContributingFactorState {
  final String description;

  ContributingFactorDescriptionUpdateState({required this.description});
}

class ContributingFactorCateogryUpdateState extends ContributingFactorState {
  final String category;

  ContributingFactorCateogryUpdateState({required this.category});
}
