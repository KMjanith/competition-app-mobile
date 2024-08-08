import 'package:flutter/material.dart';
import '../Constants/StyleConstants.dart';

class CustomDrawer extends StatelessWidget {
  final List<Widget> drawerItems;

  const CustomDrawer({super.key, required this.drawerItems});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: StyleConstants.cardBackGround,
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.filter_list,
                  color: Colors.white,
                  size: 24,
                ),
                Text(
                  'Filters',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
          ...drawerItems,
        ],
      ),
    );
  }
}
