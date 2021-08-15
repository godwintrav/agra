import 'package:agraapp/pages/investor/all_projects.dart';
import 'package:agraapp/pages/investor/investor_dashboard.dart';
import 'package:agraapp/pages/investor/notifications.dart';
import 'package:agraapp/pages/investor/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:agraapp/globals/globals.dart' as globals;

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = globals.SelectedIndexPage;
  List<Widget> _widgetOptions = <Widget>[
    InvestorDashboard(),
    Notifications(),
    InvestorProfile(),
  ];

  void _onItemTapped(int value) {
    globals.SelectedIndexPage = value;
    setState(() {
      _selectedIndex = globals.SelectedIndexPage;
    });
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => _widgetOptions.elementAt(_selectedIndex),
        ));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
      elevation: 5.0,
      onTap: (value) {
        _onItemTapped(value);
      },
    );
  }
}
