import 'package:agraapp/controllers/farm_controller.dart';
import 'package:agraapp/models/farm_class.dart';
import 'package:agraapp/pages/farmer/create_project.dart';
import 'package:agraapp/pages/farmer/farmer_dashboard.dart';
import 'package:agraapp/pages/farmer/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:agraapp/globals/globals.dart' as globals;

class SelectFarmForProject extends StatefulWidget {
  @override
  _SelectFarmForProjectState createState() => _SelectFarmForProjectState();
}

class _SelectFarmForProjectState extends State<SelectFarmForProject> {
  List<Farm> farms;
  int farmsCount;

  @override
  void initState() {
    super.initState();
    farmsCount = -1;
    getFarms();
  }

  void getFarms() async {
    farms = await FarmController().fetchFarmerFarms(globals.user_info.id);
    setState(() {
      farmsCount = farms.length;
    });
  }

  Widget _NoFarm() {
    return Center(
      child: Text(
        'No Farm Found',
        style: TextStyle(fontSize: 14, fontFamily: globals.font_family),
      ),
    );
  }

  Widget _LoadingFarm() {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.green[500],
      ),
    );
  }

  Widget _FarmCard(int index) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      height: 100,
      width: double.maxFinite,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateProject(
                  farmID: farms[index].id,
                ),
              ));
        },
        splashColor: Colors.green[500],
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 7, 7, 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    farms[index].farmTitle.toUpperCase(),
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: globals.font_family,
                        color: Colors.green[500]),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        farms[index].farmType.toUpperCase(),
                        style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: globals.font_family),
                      ),
                      Icon(
                        Icons.keyboard_arrow_right,
                        size: 20,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  Text(
                    farms[index].farmLocation.toUpperCase(),
                    style: TextStyle(
                        fontSize: 9,
                        color: Colors.grey,
                        fontFamily: globals.font_family),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _FarmList() {
    return ListView.builder(
      itemCount: farmsCount,
      itemBuilder: (context, index) {
        return _FarmCard(index);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Select farm to create project",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: globals.font_family),
          ),
          backgroundColor: Colors.green[500],
          elevation: 0.0,
        ),
        body: (farmsCount > 0)
            ? _FarmList()
            : (farmsCount == 0) ? _NoFarm() : _LoadingFarm(),
        bottomNavigationBar: BottomBar());
  }
}
