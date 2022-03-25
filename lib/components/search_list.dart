import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubics/search/search_cubit.dart';
import '../search_list_item.dart';

class SearchList extends StatelessWidget {
  const SearchList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            child: BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                switch (state.status) {
                  case SearchStatus.initial:
                    return const Text('Please enter a destination');
                  case SearchStatus.loading:
                    return const Center(child: CircularProgressIndicator());
                  case SearchStatus.pickupSuccess:
                    return ListView.builder(
                      itemCount: state.predictions!.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (_, i) => SearchListItem(
                        id: state.predictions![i].placeId,
                        title: state.predictions![i].mainText,
                        subtitle: state.predictions![i].secondaryText,
                      ),
                    );
                  case SearchStatus.failure:
                    return Text(state.exception.toString());
                  case SearchStatus.destinationSuccess:
                    return const Text('...');
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
