part of 'bool_bloc.dart';

abstract class BoolEvent {
  const BoolEvent();
}

class Get extends BoolEvent {}

class Set extends BoolEvent {
  final bool val;
  const Set({required this.val});
}