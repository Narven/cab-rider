import 'package:flutter/material.dart';

import '../constants.dart';
import 'brand_divider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
      ),
    );
  }
}
