part of 'contributing_factor_bloc.dart';

abstract class ContributingFactorEvent {
  final gen.ContributingFactor constributingFactor;

  const ContributingFactorEvent({required this.constributingFactor});
}

class Category extends ContributingFactorEvent {
  Category({required super.constributingFactor});
}

class Description extends ContributingFactorEvent {
  Description({required super.constributingFactor});
}

