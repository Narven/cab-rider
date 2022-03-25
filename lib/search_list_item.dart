import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'brand_colors.dart';
import 'cubics/search/search_cubit.dart';

class SearchListItem extends StatelessWidget {
  const SearchListItem({
    Key? key,
    required this.id,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  final String id;
  final String title;
  final String subtitle;

  Future<void> onTap(SearchCubit cubit, BuildContext context) async {
    // TODO fix this
    // await cubit.searchDestinationAddress();
    Navigator.pop(context, 'getDirection');
  }

  @override
  Widget build(BuildContext context) {
    final searchCubit = context.read<SearchCubit>();
    return ListTile(
      onTap: () => onTap(searchCubit, context),
      leading: const Icon(Icons.location_pin),
      title: Text(
        title,
        style: const TextStyle(
          overflow: TextOverflow.ellipsis,
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          fontSize: 12,
          color: BrandColors.colorDimText,
        ),
      ),
    );
  }
}
