import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../cubics/search/search_cubit.dart';

class Map extends StatefulWidget {
  const Map({Key? key}) : super(key: key);

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(49.57192852635586, -125.54818558151062),
    zoom: 12,
  );

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  double mapBottomPadding = 0;

  final Completer<GoogleMapController> _controller = Completer();

  late GoogleMapController mapController;

  Future<Position> getCurrentPosition() async {
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.bestForNavigation,
    );
  }

  @override
  void initState() {
    getCurrentPosition().then((Position position) {
      context.read<SearchCubit>().searchPickupAddress(position);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        switch (state.status) {
          case SearchStatus.initial:
            return const Center(child: Text('...'));
          case SearchStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case SearchStatus.success:
            return GoogleMap(
              padding: EdgeInsets.only(bottom: mapBottomPadding),
              myLocationEnabled: true,
              initialCameraPosition: Map._kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                mapController = controller;

                setState(() {
                  mapBottomPadding = Platform.isAndroid ? 200 : 270;
                });

                // setupPositionLocator();
              },
            );
          case SearchStatus.failure:
            return Center(child: Text(state.exception.toString()));
        }
      },
    );
  }
}
