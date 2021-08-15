import 'package:agraapp/pages/investor/investor_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:agraapp/globals/globals.dart' as globals;

class InvestorHome extends StatefulWidget {
  @override
  _InvestorHomeState createState() => _InvestorHomeState();
}

class _InvestorHomeState extends State<InvestorHome> {
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
      InvestorDashboard(),
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
