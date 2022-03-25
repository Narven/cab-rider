import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';

import '../../data/models/address_model.dart';
import '../../data/models/direction_details_model.dart';
import '../../data/models/prediction_model.dart';
import '../../data/repositories/search_repository.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit({
    required this.searchRepository,
    required this.logger,
  }) : super(const SearchState());

  final SearchRepository searchRepository;
  final Logger logger;

  Future<void> searchPickupAddress(Position position) async {
    emit(state.copyWith(status: SearchStatus.loading));

    try {
      final address = await searchRepository.getAddress(position);

      logger.d(address);

      emit(
        state.copyWith(
          status: SearchStatus.pickupSuccess,
          pickupAddress: address,
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: SearchStatus.failure,
          exception: e,
        ),
      );
    }
  }

  Future<void> getDirections() async {
    emit(state.copyWith(status: SearchStatus.loading));

    try {
      final start = LatLng(
        state.pickupAddress!.latitude,
        state.pickupAddress!.longitude,
      );

      final end = LatLng(
        state.destinationAddress!.latitude,
        state.destinationAddress!.longitude,
      );

      final directions = searchRepository.fetchDirectionDetails(
        start: start,
        end: end,
      );

      logger.d(directions);

      //
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: SearchStatus.failure,
          exception: e,
        ),
      );
    }
  }

  Future<void> searchDestinationAddress(String placeId) async {
    emit(state.copyWith(status: SearchStatus.loading));

    try {
      // TODO fix this
      // final location = await searchRepository..fetchByLocationName(placeId);

      // final address = await searchRepository.getAddress(position);

      // print(address);

      emit(
        state.copyWith(
          status: SearchStatus.destinationSuccess,
          // destinationAddress: address,
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: SearchStatus.failure,
          exception: e,
        ),
      );
    }
  }

  /// Fetch a list of predictions by a location name
  Future<void> fetchByLocationName(String locationName) async {
    emit(state.copyWith(status: SearchStatus.loading));

    try {
      final predictions = await searchRepository.fetchByLocationName(
        locationName,
      );

      emit(
        SearchState(
          status: SearchStatus.pickupSuccess,
          predictions: predictions,
        ),
      );
    } on Exception catch (e) {
      emit(SearchState(status: SearchStatus.failure, exception: e));
    }
  }
}
