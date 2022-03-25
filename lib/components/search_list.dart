import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubics/predictions/prediction_cubit.dart';
import '../search_list_item.dart';

class SearchList extends StatelessWidget {
  const SearchList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            child: BlocBuilder<PredictionCubit, PredictionState>(
              builder: (context, state) {
                if (state is PredictionInitial) {
                  return const Text('Please enter a destination');
                }
                if (state is PredictionSuccess) {
                  return ListView.builder(
                    itemCount: state.predictions.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (_, i) => SearchListItem(
                      id: state.predictions[i].placeId,
                      title: state.predictions[i].mainText,
                      subtitle: state.predictions[i].secondaryText,
                    ),
                  );
                }
                if (state is PredictionLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is PredictionError) {
                  return Text(state.message);
                }
                return const Text('...');
              },
            ),
          ),
        ],
      ),
    );
  }
}
