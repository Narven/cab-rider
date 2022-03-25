part of 'prediction_cubit.dart';

@immutable
abstract class PredictionState {}

class PredictionInitial extends PredictionState {}

class PredictionLoading extends PredictionState {}

class PredictionSuccess extends PredictionState {
  PredictionSuccess(this.predictions);
  final List<PredictionModel> predictions;
}

class PredictionError extends PredictionState {
  PredictionError(this.message);
  final String message;
}
