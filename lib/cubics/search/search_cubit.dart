import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

import '../../data/models/address_model.dart';
import '../../data/models/prediction_model.dart';
import '../../data/repositories/search_repository.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit({required this.searchRepository}) : super(const SearchState());

  final SearchRepository searchRepository;

  Future<void> searchPickupAddress(Position position) async {
    emit(state.copyWith(status: SearchStatus.loading));

    try {
      final address = await searchRepository.getAddress(position);

      print(address);

      emit(
        state.copyWith(
          status: SearchStatus.success,
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

  Future<void> searchDestinationAddress(String placeId) async {
    emit(state.copyWith(status: SearchStatus.loading));

    try {
      // TODO fix this
      // final location = await searchRepository..fetchByLocationName(placeId);

      // final address = await searchRepository.getAddress(position);

      // print(address);

      emit(
        state.copyWith(
          status: SearchStatus.success,
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

  // Future<void> searchPlaceDetails(String placeId) async {
  //   emit(state.copyWith(status: SearchStatus.loading));

  //   try {
  //     final address = await searchRepository.searchPlaceId(placeId);

  //     emit(AddressDetailsSuccess(addressDetails));
  //   } catch (e) {
  //     emit(AddressDetailsError(e.toString()));
  //   }
  // }
}
