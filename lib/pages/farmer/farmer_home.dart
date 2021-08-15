import 'package:agraapp/pages/farmer/farmer_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:agraapp/globals/globals.dart' as globals;

class FarmerHome extends StatefulWidget {
  @override
  _FarmerHomeState createState() => _FarmerHomeState();
}

class _FarmerHomeState extends State<FarmerHome> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions;

  void _onItemTapped(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }

  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[
      FarmerDashboard(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.dashboard,
                size: 30,
              ),
              title: Container()),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.notifications,
                size: 30,
              ),
              title: Container()),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle,
                size: 30,
              ),
              title: Container()),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green[500],
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey,
        elevation: 3.0,
        onTap: (value) {
          _onItemTapped(value);
        },
      ),
    );
  }
}
