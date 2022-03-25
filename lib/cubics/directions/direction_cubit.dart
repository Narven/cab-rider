import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';

import '../../data/models/direction_details_model.dart';
import '../../data/repositories/search_repository.dart';

part 'direction_state.dart';

class DirectionCubit extends Cubit<DirectionState> {
  DirectionCubit({required this.searchRepository, required this.logger})
      : super(DirectionInitial());

  final SearchRepository searchRepository;
  final Logger logger;

  Future<void> getDirection(LatLng start, LatLng end) async {
    emit(DirectionLoading());

    try {
      final direction = await searchRepository.fetchDirectionDetails(
        startPosition: start,
        endPosition: end,
      );

      logger.d(direction);

      emit(DirectionSuccess(direction));
    } catch (e) {
      logger.e(e);
      emit(DirectionError(e.toString()));
    }
  }
}
