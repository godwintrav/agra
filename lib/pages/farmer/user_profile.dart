import 'package:agraapp/pages/farmer/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:agraapp/globals/globals.dart' as globals;

class FarmerProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('User Profile'),
          centerTitle: true,
          backgroundColor: Colors.green[500],
          elevation: 0.0,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(
            Icons.edit,
            color: Colors.white,
          ),
          backgroundColor: Colors.green[500],
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0.0),
          child: ListView(
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.green[500],
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    globals.user_info.firstName[0].toUpperCase(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Divider(
                height: 60.0,
                color: Colors.grey,
              ),
              Text(
                'FIRST NAME',
                style: TextStyle(
                    color: Colors.grey, letterSpacing: 2.0, fontSize: 12),
              ),
              SizedBox(height: 10.0),
              Text(
                globals.user_info.firstName.toUpperCase(),
                style: TextStyle(
                  color: Colors.green[500],
                  letterSpacing: 2.0,
                  fontSize: 18.0,
                  fontFamily: globals.font_family,
                ),
              ),
              SizedBox(height: 30.0),
              Text(
                'LAST NAME',
                style: TextStyle(
                    color: Colors.grey, letterSpacing: 2.0, fontSize: 12),
              ),
              SizedBox(height: 10.0),
              Text(
                globals.user_info.lastName.toUpperCase(),
                style: TextStyle(
                  color: Colors.green[500],
                  letterSpacing: 2.0,
                  fontSize: 18.0,
                  fontFamily: globals.font_family,
                ),
              ),
              SizedBox(height: 30.0),
              Text(
                'PHONE',
                style: TextStyle(
                    color: Colors.grey, letterSpacing: 2.0, fontSize: 12),
              ),
              SizedBox(height: 10.0),
              Text(
                globals.user_info.phone,
                style: TextStyle(
                  color: Colors.green[500],
                  letterSpacing: 1.0,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 30.0),
              Text(
                'USER TYPE',
                style: TextStyle(
                    color: Colors.grey, letterSpacing: 2.0, fontSize: 12),
              ),
              SizedBox(height: 10.0),
              Text(
                globals.user_info.userType.toUpperCase(),
                style: TextStyle(
                  color: Colors.green[500],
                  letterSpacing: 1.0,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 30.0),
            ],
          ),
        ),
        bottomNavigationBar: BottomBar());
  }
}
