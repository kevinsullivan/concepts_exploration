import 'package:equatable/equatable.dart';

abstract class IntEvent extends Equatable {
  const IntEvent();

  @override
  List<Object> get props => [];
}

class Get extends IntEvent {}

class Set extends IntEvent {
  final int val;

  const Set({required this.val});
}
