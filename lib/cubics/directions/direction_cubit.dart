import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

import '../../data/models/direction_details_model.dart';
import '../../data/repositories/search_repository.dart';

part 'direction_state.dart';

class DirectionCubit extends Cubit<DirectionState> {
  DirectionCubit(this._searchHelper) : super(DirectionInitial());

  final SearchRepository _searchHelper;

  Future<void> getDirection(LatLng start, LatLng end) async {
    emit(DirectionLoading());
    print('try');

    try {
      final direction = await _searchHelper.fetchDirectionDetails(
        startPosition: start,
        endPosition: end,
      );

      print(direction);

      emit(DirectionSuccess(direction));
    } catch (e) {
      print(e);
      emit(DirectionError(e.toString()));
    }
  }
}
