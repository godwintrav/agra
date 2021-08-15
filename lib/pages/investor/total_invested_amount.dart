import 'package:agraapp/controllers/investor_controller.dart';
import 'package:agraapp/pages/investor/all_projects.dart';
import 'package:flutter/material.dart';
import 'package:agraapp/globals/globals.dart' as globals;

class TotalInvestedAmount extends StatefulWidget {
  @override
  _TotalInvestedAmountState createState() => _TotalInvestedAmountState();
}

class _TotalInvestedAmountState extends State<TotalInvestedAmount> {
  Map<String, dynamic> result;
  int condition;
  @override
  void initState() {
    super.initState();
    result = {};
    condition = 0;
    getData();
  }

  void getData() async {
    result = await InvestorController().fetchInvestedAmount();
    setState(() {
      condition = result['value'];
      if (condition == 2) {
        result['data'] = 0;
      }
    });
  }

  Widget _NoDataWidget() {
    return Center(
      child: Text(
        'Error getting information',
        style: TextStyle(
            fontSize: 14, fontFamily: globals.font_family, color: Colors.red),
      ),
    );
  }

  Widget _DisplayDataWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Total Amount Invested:',
            style: TextStyle(
                fontSize: 14,
                fontFamily: globals.font_family,
                color: Colors.green[500]),
          ),
          SizedBox(
            height: 1,
          ),
          Text('\$' + result['data'].toString(),
              style: TextStyle(fontSize: 30, fontFamily: globals.font_family)),
          SizedBox(
            height: 60,
          ),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.greenAccent[400], width: 2.0),
                  borderRadius: BorderRadius.circular(25.0)),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AllProjects(),
                    ));
              },
              color: Colors.greenAccent[400],
              child: Text(
                'Check Available Projects',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: globals.font_family,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _LoadingWidget() {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.green[500],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "TOTAL AMOUNT INVESTED",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: globals.font_family),
        ),
        backgroundColor: Colors.green[500],
        elevation: 0.0,
      ),
      body: (condition == 1 || condition == 2)
          ? _DisplayDataWidget()
          : (condition == -1) ? _NoDataWidget() : _LoadingWidget(),
    );
  }
}
