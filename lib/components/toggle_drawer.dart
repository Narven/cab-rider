import 'package:flutter/material.dart';

class ToggleDrawer extends StatelessWidget {
  const ToggleDrawer({Key? key, required this.onTap}) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5.0,
              spreadRadius: 0.5,
              offset: Offset(0.7, 0.7),
            )
          ],
        ),
        child: const CircleAvatar(
          backgroundColor: Colors.white,
          radius: 20,
          child: Icon(
            Icons.menu,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
