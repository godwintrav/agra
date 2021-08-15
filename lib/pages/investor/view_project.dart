import 'package:agraapp/controllers/investor_controller.dart';
import 'package:agraapp/models/project_class.dart';
import 'package:agraapp/pages/investor/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:agraapp/globals/globals.dart' as globals;
import 'package:intl/intl.dart';

class InvestorViewProject extends StatefulWidget {
  final Project project;

  const InvestorViewProject({Key key, this.project}) : super(key: key);
  @override
  _InvestorViewProjectState createState() => _InvestorViewProjectState();
}

class _InvestorViewProjectState extends State<InvestorViewProject> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  double amount = 0;
  double profit = 0;
  int errCheck;
  void _showErrDialog(String errMsg) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Error Funding Farm Project',
              style: TextStyle(
                fontFamily: globals.font_family,
                fontSize: 16,
                color: Colors.red,
              ),
            ),
            content: Row(
              children: <Widget>[
                Flexible(
                  child: Text(
                    '$errMsg',
                  ),
                ),
                Icon(
                  Icons.cancel,
                  color: Colors.red,
                )
              ],
            ),
            actions: <Widget>[
              new FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('close'))
            ],
          );
        });
  }

  void _showLoadingDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 70,
              width: 50,
              child: Center(
                child: Column(
                  children: <Widget>[
                    CircularProgressIndicator(
                      backgroundColor: Colors.green,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Please wait.....',
                      style: TextStyle(
                          color: Colors.green, fontFamily: globals.font_family),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  void _showSuccessDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Success',
              style: TextStyle(
                fontFamily: globals.font_family,
                fontSize: 16,
                color: Colors.green,
              ),
            ),
            content: Row(
              children: <Widget>[
                Text('Investment Successsful.'),
                Icon(
                  Icons.offline_pin,
                  color: Colors.green[500],
                )
              ],
            ),
            actions: <Widget>[
              new FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pushReplacementNamed(
                        context, '/investorDashboard');
                  },
                  child: Text('close'))
            ],
          );
        });
  }

  Widget _buildAmount() {
    return TextFormField(
      keyboardType: TextInputType.number,
      onChanged: (value) {
        if (value.isEmpty) {
          setState(() {
            profit = 0;
          });
        }
        amount = double.parse(value);
        setState(() {
          profit = amount * (widget.project.percentageReturns / 100);
        });
      },
      decoration: new InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green[500], width: 1.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.0),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green[500], width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1.0),
          ),
          errorStyle: TextStyle(height: 0, fontSize: 0)),
      validator: (value) {
        if (value.isEmpty) {
          return 'Amount is required';
        }
        return null;
      },
      onSaved: (newValue) {
        amount = double.parse(newValue);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.project.farm.farmTitle.toUpperCase()),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.green[500],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  Icons.location_on,
                  size: 28,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  widget.project.farm.farmLocation.toUpperCase() + ".",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: globals.font_family),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'DATE FOUNDED: ${DateFormat.yMMMd().format(widget.project.farm.farmEstablishDate)}',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.45,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          '${globals.apiUrl}${globals.farmImgUrl}${widget.project.farm.id}/attachments/${widget.project.farm.farmImage}'),
                      fit: BoxFit.cover)),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.check_circle,
                  color: Colors.green[500],
                  size: 28,
                ),
                SizedBox(
                  width: 12,
                ),
                Text(
                  'Required Amount: \$${widget.project.requiredAmount}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: globals.font_family),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.check_circle,
                  color: Colors.green[500],
                  size: 28,
                ),
                SizedBox(
                  width: 12,
                ),
                Text(
                  'Percentage Return: ${widget.project.percentageReturns}%',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: globals.font_family),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.check_circle,
                  color: Colors.green[500],
                  size: 28,
                ),
                SizedBox(
                  width: 12,
                ),
                Text(
                  'Project Duration: ${widget.project.duration} weeks',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: globals.font_family),
                )
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          '\$',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.red),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: 40,
                          child: _buildAmount(),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'Profit: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Flexible(
                          child: Text(
                            '\$$profit ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Colors.greenAccent[400], width: 2.0),
                            borderRadius: BorderRadius.circular(25.0)),
                        onPressed: () async {
                          _showLoadingDialog();
                          if (!_formKey.currentState.validate()) {
                            Navigator.of(context).pop();
                            _showErrDialog('Enter investment amount.');
                            return;
                          }
                          _formKey.currentState.save();
                          Map<String, dynamic> result =
                              await InvestorController().fundFarmProject(
                                  widget.project.id,
                                  globals.user_info.user_id,
                                  "investment",
                                  amount);
                          Navigator.of(context).pop();
                          setState(() {});
                          if (result['value'] == globals.positive_status) {
                            _showSuccessDialog();
                          } else {
                            _showErrDialog(result['data']);
                          }
                          return;
                        },
                        color: Colors.greenAccent[400],
                        child: Text(
                          'Sponsor This Project',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: globals.font_family,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                )),
            SizedBox(
              height: 25,
            ),
            Text('Project Detail',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    fontFamily: globals.font_family)),
            SizedBox(
              height: 10,
            ),
            Text(
              '${widget.project.detail}',
              style: TextStyle(
                  color: Colors.grey,
                  fontFamily: globals.font_family,
                  fontSize: 14),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
