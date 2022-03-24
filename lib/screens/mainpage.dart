import 'dart:async';
import 'dart:io';

import 'package:cab_rider/components/search_panel.dart';
import 'package:cab_rider/components/toggle_drawer.dart';
import 'package:cab_rider/helpers/location_helper.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../components/custom_drawer.dart';

class MainPage extends StatefulWidget {
  static const String routeName = '/mainpage';
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController mapController;
  double mapBottomPadding = 0;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final geoLocator = Geolocator();

  Future<void> checkLocationPermissions() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return Future.value();
  }

  Future<void> setupPositionLocator() async {
    try {
      await checkLocationPermissions();
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation,
      );

      final pos = LatLng(position.latitude, position.longitude);
      final cp = CameraPosition(target: pos, zoom: 14);
      mapController.animateCamera(CameraUpdate.newCameraPosition(cp));

      String address = await LocationHelper.findCoordinateAddress(position);
      print(address);
    } catch (e) {
      print(e);
    }
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(49.57192852635586, -125.54818558151062),
    zoom: 12,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const CustomDrawer(),
      body: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(bottom: mapBottomPadding),
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              mapController = controller;

              setState(() {
                mapBottomPadding = Platform.isAndroid ? 200 : 270;
              });

              setupPositionLocator();
            },
          ),
          Positioned(
            top: 44,
            left: 20,
            child: ToggleDrawer(
              onTap: () {
                scaffoldKey.currentState?.openDrawer();
              },
            ),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            right: 0,
            child: SearchPanel(),
          )
        ],
      ),
    );
  }
}
