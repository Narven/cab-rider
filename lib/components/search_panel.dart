import 'dart:io';

import 'package:flutter/material.dart';

import '../brand_colors.dart';
import 'brand_divider.dart';

class SearchPanel extends StatelessWidget {
  SearchPanel({Key? key}) : super(key: key);

  double searchSheetHeight = Platform.isIOS ? 300 : 275;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: searchSheetHeight,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 15.0,
            spreadRadius: 0.5,
          )
        ],
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
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5.0,
                    spreadRadius: 0.5,
                    offset: Offset(0.7, 0.7),
                  )
                ],
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
                        fontSize: 18,
                        fontFamily: 'Brand-Bold',
                      ),
                    ),
                  ],
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
