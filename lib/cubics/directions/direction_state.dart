part of 'direction_cubit.dart';

@immutable
abstract class DirectionState {}

class DirectionInitial extends DirectionState {}

class DirectionLoading extends DirectionState {}

class DirectionSuccess extends DirectionState {
  DirectionSuccess(this.direction);
  final DirectionDetailsModel direction;
}

class DirectionError extends DirectionState {
  DirectionError(this.message);
  final String message;
}
