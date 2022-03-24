import 'dart:async';
import 'dart:io';

import 'package:cab_rider/brand_colors.dart';
import 'package:cab_rider/components/brand_divider.dart';
import 'package:cab_rider/components/toggle_drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../constants.dart';

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
  double searchSheetHeight = Platform.isIOS ? 300 : 275;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(49.57192852635586, -125.54818558151062),
    zoom: 12,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: Container(
          width: 250,
          color: Colors.white,
          child: Drawer(
            child: ListView(
              padding: const EdgeInsets.all(0),
              children: [
                Container(
                  color: Colors.white,
                  height: 160,
                  child: DrawerHeader(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Image.asset(
                            'assets/images/user_icon.png',
                            height: 60,
                            width: 60,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Pedro Luz',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Brand-Bold',
                              ),
                            ),
                            SizedBox(height: 5),
                            Text('View Profile')
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const BrandDivider(),
                const SizedBox(height: 10),
                const ListTile(
                  leading: Icon(Icons.wallet_giftcard),
                  title: Text(
                    'Free Rides',
                    style: kDrawerItemStyle,
                  ),
                ),
                const ListTile(
                  leading: Icon(Icons.credit_card),
                  title: Text(
                    'Payments',
                    style: kDrawerItemStyle,
                  ),
                ),
                const ListTile(
                  leading: Icon(Icons.history),
                  title: Text(
                    'Ride History',
                    style: kDrawerItemStyle,
                  ),
                ),
                const ListTile(
                  leading: Icon(Icons.contact_support),
                  title: Text(
                    'Support',
                    style: kDrawerItemStyle,
                  ),
                ),
                const ListTile(
                  leading: Icon(Icons.info),
                  title: Text(
                    'About',
                    style: kDrawerItemStyle,
                  ),
                )
              ],
            ),
          )),
      body: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(bottom: mapBottomPadding),
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              mapController = controller;

              setState(() {
                mapBottomPadding = Platform.isAndroid ? 200 : 270;
              });
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
            child: Container(
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: const Icon(
                            Icons.home,
                            color: BrandColors.colorDimText,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Add Home'),
                            const SizedBox(height: 3),
                            const Text(
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: const Icon(
                            Icons.work,
                            color: BrandColors.colorDimText,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Add Work'),
                            const SizedBox(height: 3),
                            const Text(
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
            ),
          )
        ],
      ),
    );
  }
}
