import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../brand_colors.dart';
import '../../components/progress_dialog.dart';
import '../../components/search_list.dart';
import '../../constants.dart';
import '../../cubics/predictions/prediction_cubit.dart';
import '../../cubics/search/search_cubit.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final pickupController = TextEditingController();
  final destinationController = TextEditingController();

  final focusDestination = FocusNode();
  bool focused = false;

  void setFocus() {
    if (!focused) {
      FocusScope.of(context).requestFocus(focusDestination);
      focused = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    setFocus();
    return Scaffold(
      body: BlocListener<SearchCubit, SearchState>(
        listener: (context, state) {
          switch (state.status) {
            case SearchStatus.initial:
              break;
            case SearchStatus.loading:
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) =>
                    const ProgressDialog(status: 'Please wait...'),
              );
              break;
            case SearchStatus.success:
              Navigator.pop(context);
              break;
            case SearchStatus.failure:
              Navigator.pop(context);
              break;
          }
        },
        child: Column(
          children: [
            Container(
              // height: 230,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [kBoxShadow],
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 24,
                  top: 48,
                  right: 24,
                  bottom: 20,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 5),
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.arrow_back),
                        ),
                        const Center(
                          child: Text(
                            'Set Destination',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Brand-Bold',
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/pickicon.png',
                          height: 16,
                          width: 16,
                        ),
                        const SizedBox(width: 18),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: BrandColors.colorLightGrayFair,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: BlocBuilder<SearchCubit, SearchState>(
                                builder: (context, state) {
                                  switch (state.status) {
                                    case SearchStatus.initial:
                                      return Container();
                                    case SearchStatus.loading:
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    case SearchStatus.success:
                                      pickupController.text =
                                          state.pickupAddress!.placeName;

                                      return TextField(
                                        controller: pickupController,
                                        decoration: const InputDecoration(
                                          hintText: 'Pickup Location',
                                          fillColor:
                                              BrandColors.colorLightGrayFair,
                                          filled: true,
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.only(
                                            left: 10,
                                            top: 8,
                                            bottom: 8,
                                          ),
                                        ),
                                      );
                                    case SearchStatus.failure:
                                      return Center(
                                        child: Text(state.exception.toString()),
                                      );
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/pickicon.png',
                          height: 16,
                          width: 16,
                        ),
                        const SizedBox(width: 18),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: BrandColors.colorLightGrayFair,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: TextField(
                                onChanged: (value) {
                                  context
                                      .read<PredictionCubit>()
                                      .searchPlace(value);
                                },
                                controller: destinationController,
                                focusNode: focusDestination,
                                decoration: const InputDecoration(
                                  hintText: 'Where to?',
                                  fillColor: BrandColors.colorLightGrayFair,
                                  filled: true,
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                    left: 10,
                                    top: 8,
                                    bottom: 8,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const Expanded(
              child: SearchList(),
            ),
          ],
        ),
      ),
    );
  }
}
