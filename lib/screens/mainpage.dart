import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../components/custom_drawer.dart';
import '../components/map.dart';
import '../components/search_panel.dart';
import '../components/toggle_drawer.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  static const String routeName = '/mainpage';

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final geoLocator = Geolocator();

  Future<void> checkLocationPermissions() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }
    return Future.value();
  }

  // Future<void> setupPositionLocator() async {
  //   try {
  //     await checkLocationPermissions();
  //     final position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.bestForNavigation,
  //     );
  //
  //     final pos = LatLng(position.latitude, position.longitude);
  //     final cp = CameraPosition(target: pos, zoom: 14);
  //     mapController.animateCamera(CameraUpdate.newCameraPosition(cp));
  //
  //     // final address = await SearchHelper.findCoordinateAddress(position);
  //     print(address);
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const CustomDrawer(),
      body: Stack(
        children: [
          Map(),
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
