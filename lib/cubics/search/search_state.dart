part of 'search_cubit.dart';

enum SearchStatus { initial, loading, success, failure }

class SearchState extends Equatable {
  const SearchState({
    this.status = SearchStatus.initial,
    this.pickupAddress,
    this.destinationAddress,
    this.predictions,
    this.exception,
  });

  final SearchStatus status;
  final AddressModel? destinationAddress;
  final AddressModel? pickupAddress;
  final List<PredictionModel>? predictions;
  final Exception? exception;

  @override
  List<Object?> get props => [
        status,
        pickupAddress,
        destinationAddress,
        exception,
      ];

  SearchState copyWith({
    SearchStatus? status,
    AddressModel? pickupAddress,
    AddressModel? destinationAddress,
    Exception? exception,
  }) {
    return SearchState(
      status: status ?? this.status,
      pickupAddress: pickupAddress ?? this.pickupAddress,
      destinationAddress: destinationAddress ?? this.destinationAddress,
      exception: exception ?? this.exception,
    );
  }
}
