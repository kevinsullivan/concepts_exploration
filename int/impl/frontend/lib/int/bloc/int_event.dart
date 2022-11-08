part of 'int_bloc.dart';

abstract class IntEvent {
  const IntEvent();
}

class Get extends IntEvent {}

class Set extends IntEvent {
  final int val;
  const Set({required this.val});
}
