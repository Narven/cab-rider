import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/models/prediction_model.dart';
import '../../data/repositories/search_repository.dart';

part 'prediction_state.dart';

class PredictionCubit extends Cubit<PredictionState> {
  PredictionCubit(this.searchRepository) : super(PredictionInitial());

  final SearchRepository searchRepository;

  Future<void> searchPlace(String name) async {
    emit(PredictionLoading());

    try {
      final predictions = await searchRepository.fetchByLocationName(name);

      emit(PredictionSuccess(predictions));
    } catch (e) {
      PredictionError(e.toString());
    }
  }
}
