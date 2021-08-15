import 'package:agraapp/pages/farmer/create_farm.dart';
import 'package:agraapp/pages/farmer/create_project.dart';
import 'package:agraapp/pages/farmer/farmer_dashboard.dart';
import 'package:agraapp/pages/farmer/farmer_home.dart';
import 'package:agraapp/pages/farmer/view_farms.dart';
import 'package:agraapp/pages/homepage.dart';
import 'package:agraapp/pages/investor/investor_dashboard.dart';
import 'package:agraapp/pages/investor/investor_home.dart';
import 'package:agraapp/pages/investor/view_farms.dart';
import 'package:agraapp/pages/investor/view_project.dart';
import 'package:agraapp/pages/login.dart';
import 'package:agraapp/pages/register.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Homepage(),
    theme: ThemeData(accentColor: Colors.white),
    routes: {
      '/register': (context) => Register(),
      '/login': (context) => Login(),
      '/homepage': (context) => Homepage(),
      '/create_farm': (context) => CreateFarm(),
      '/farmerDashboard': (context) => FarmerDashboard(),
      '/investorDashboard': (context) => InvestorDashboard(),
      '/investorViewProject': (context) => InvestorViewProject(),
      '/farmerHome': (context) => FarmerHome(),
      '/investorHome': (context) => InvestorHome(),
      '/viewMyFarms': (context) => ViewMyFarms(),
    },
  ));
}
