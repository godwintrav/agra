import 'package:agraapp/pages/farmer/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:agraapp/globals/globals.dart' as globals;

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  Widget _NoNotification() {
    return Center(
      child: Text(
        'No Notifications Found',
        style: TextStyle(fontSize: 14, fontFamily: globals.font_family),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notifications",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: globals.font_family),
        ),
        backgroundColor: Colors.green[500],
        elevation: 0.0,
      ),
      body: _NoNotification(),
      bottomNavigationBar: BottomBar(),
    );
  }
}
