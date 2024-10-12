import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'bottomscreen.dart/calculatescreen.dart';
import 'bottomscreen.dart/homepage.dart';
import 'bottomscreen.dart/lsitscreen.dart';
import 'bottomscreen.dart/profilescreen.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    HomePage(studentsWithLessThanAmount: []),
    const ListScreen(),
    const CalculateScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white, // Color under the nav bar
        color: Color.fromRGBO(240, 240, 240, 1.0),
        buttonBackgroundColor: const Color.fromRGBO(240, 240, 240,
            1.0), //253,245,230  188,136,93 Color of the selected item
        height: 60, // Adjust the height if needed
        index: _selectedIndex,
        items: const <Widget>[
          Icon(Icons.home),
          Icon(Icons.list, size: 30),
          Icon(Icons.calculate, size: 30),
          Icon(Icons.account_circle_rounded, size: 30),
        ],
        onTap: _onItemTapped,
        animationDuration:
            const Duration(milliseconds: 300), // Smooth animation
        animationCurve: Curves.easeInOut, // Animation curve for item switching
      ),
    );
  }
}
