import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../brand_colors.dart';
import '../constants.dart';
// import '../cubics/directions/direction_cubit.dart';
import '../cubics/search/search_cubit.dart';
import '../screens/search/search_screen.dart';
import 'brand_divider.dart';

class SearchPanel extends StatelessWidget {
  SearchPanel({Key? key}) : super(key: key);

  double searchSheetHeight = Platform.isIOS ? 300 : 275;

  @override
  Widget build(BuildContext context) {
    final searchBloc = BlocProvider.of<SearchCubit>(context);
    return Container(
      height: searchSheetHeight,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        boxShadow: [kBoxShadow],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            const Text(
              'Nice to see you!',
              style: TextStyle(fontSize: 10),
            ),
            const Text(
              'Where are you going?',
              style: TextStyle(fontSize: 18, fontFamily: 'Brand-Bold'),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SearchScreen(),
                  ),
                );

                if (result == 'getDirection') {
                  await searchBloc.getDirections();
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: const [kBoxShadow],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.search,
                        color: Colors.blueAccent,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Search Destination',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Brand-Bold',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 22),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.home,
                    color: BrandColors.colorDimText,
                  ),
                ),
                const SizedBox(height: 3),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Add Home'),
                    SizedBox(height: 3),
                    Text(
                      'Your residential address',
                      style: TextStyle(
                        fontSize: 11,
                        color: BrandColors.colorDimText,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            const BrandDivider(),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.work,
                    color: BrandColors.colorDimText,
                  ),
                ),
                const SizedBox(height: 3),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Add Work'),
                    SizedBox(height: 3),
                    Text(
                      'Your office address',
                      style: TextStyle(
                        fontSize: 11,
                        color: BrandColors.colorDimText,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
