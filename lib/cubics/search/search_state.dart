part of 'search_cubit.dart';

enum SearchStatus {
  initial,
  loading,
  pickupSuccess,
  destinationSuccess,
  failure,
}

class SearchState extends Equatable {
  const SearchState({
    this.status = SearchStatus.initial,
    this.pickupAddress,
    this.destinationAddress,
    this.predictions = const [],
    this.directions = const [],
    this.exception,
  });

  final SearchStatus status;
  final AddressModel? destinationAddress;
  final AddressModel? pickupAddress;
  final List<PredictionModel>? predictions;
  final List<DirectionDetailsModel>? directions;
  final Exception? exception;

  @override
  List<Object?> get props => [
        status,
        pickupAddress,
        destinationAddress,
        predictions,
        directions,
        exception,
      ];

  SearchState copyWith({
    SearchStatus? status,
    AddressModel? pickupAddress,
    AddressModel? destinationAddress,
    List<PredictionModel>? predictions,
    List<DirectionDetailsModel>? directions,
    Exception? exception,
  }) {
    return SearchState(
      status: status ?? this.status,
      pickupAddress: pickupAddress ?? this.pickupAddress,
      destinationAddress: destinationAddress ?? this.destinationAddress,
      predictions: predictions ?? this.predictions,
      directions: directions ?? this.directions,
      exception: exception ?? this.exception,
    );
  }
}
