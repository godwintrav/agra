import 'package:agraapp/controllers/farm_controller.dart';
import 'package:agraapp/models/project_class.dart';
import 'package:agraapp/pages/farmer/navigation_bar.dart';
import 'package:agraapp/pages/farmer/view_projects.dart';
import 'package:flutter/material.dart';
import 'package:agraapp/globals/globals.dart' as globals;
import 'package:multi_image_picker/multi_image_picker.dart';

class CreateProject extends StatefulWidget {
  final int farmID;

  const CreateProject({Key key, this.farmID}) : super(key: key);
  @override
  _CreateProjectState createState() => _CreateProjectState();
}

class _CreateProjectState extends State<CreateProject> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _showDate = false;
  bool barrierVisible = false;
  FocusNode projectTypeNode = new FocusNode();
  FocusNode projectDetailNode = new FocusNode();
  FocusNode projectEstimatedReturnsNode = new FocusNode();
  FocusNode projectDurationNode = new FocusNode();
  FocusNode projectRequiredAmountNode = new FocusNode();
  FocusNode projectPercentageReturnsNode = new FocusNode();
  FocusNode dateEstNode = new FocusNode();
  String projectType;
  String projectdetail;
  double projectEstimatedReturns;
  int projectDuration;
  double projectRequiredAmount;
  double projectPercentageReturns;
  DateTime initial_date = DateTime.now();
  DateTime est_date = null;
  List<Asset> images = List<Asset>();
  dynamic err_msg;
  Map<String, dynamic> result;
  int check = 1;
  bool errCheck = false;
  Project project;

  @override
  void initState() {
    super.initState();
    result = {};
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: initial_date,
        firstDate: DateTime(1900),
        lastDate: DateTime(2021));
    if (picked != null && picked != initial_date) {
      setState(() {
        est_date = picked;
        _showDate = true;
      });
    }
  }

  void _showErrDialog(String errMsg) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Error Creating Farm',
              style: TextStyle(
                fontFamily: globals.font_family,
                fontSize: 16,
                color: Colors.red,
              ),
            ),
            content: Row(
              children: <Widget>[
                Text('$errMsg'),
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
                Text('Farm Project Created.'),
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewMyProjects(),
                        ));
                  },
                  child: Text('close'))
            ],
          );
        });
  }

  Widget _buildFailMsg() {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Card(
          color: Colors.redAccent,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '${this.err_msg}',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
                SizedBox(
                  width: 2.0,
                ),
                Icon(Icons.cancel, color: Colors.white)
              ],
            )),
          )),
    );
  }

  Widget _buildCurrentState() {
    if (check == -1) {
      return _buildFailMsg();
    }
    return Container();
  }

  Widget _buildDetail() {
    return Material(
      borderRadius: BorderRadius.circular(30),
      elevation: 1,
      child: TextFormField(
        maxLines: 8,
        focusNode: projectDetailNode,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelText: 'Project Detail',
          hintStyle: TextStyle(
            fontFamily: globals.font_family,
            fontSize: 14,
            letterSpacing: 1,
            color: Colors.grey,
          ),
          contentPadding: new EdgeInsets.fromLTRB(20, 20, 0, 20),
          isDense: true,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                width: 1,
                color: Colors.white,
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                width: 1,
                color: Colors.white,
              )),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              width: 1,
              color: Colors.white,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              width: 1.5,
              color: Colors.red,
            ),
          ),
          errorStyle: TextStyle(height: 0, fontSize: 0),
          labelStyle: TextStyle(
            fontFamily: globals.font_family,
            fontSize: 16,
            letterSpacing: 1,
            color: projectDetailNode.hasFocus ? Colors.green[500] : Colors.grey,
          ),
        ),
        validator: (String value) {
          if (value.isEmpty) {
            errCheck = true;
            return 'Project Detail is Required';
          }

          return null;
        },
        onSaved: (String newValue) {
          projectdetail = newValue;
        },
      ),
    );
  }

  Widget _buildProjectEstimatedReturns() {
    return Material(
      borderRadius: BorderRadius.circular(30),
      elevation: 1,
      child: TextFormField(
        focusNode: projectEstimatedReturnsNode,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelText: 'Estimated Returns(\$)',
          hintStyle: TextStyle(
            fontFamily: globals.font_family,
            fontSize: 12,
            letterSpacing: 0,
            color: Colors.grey,
          ),
          contentPadding: new EdgeInsets.fromLTRB(20, 20, 0, 20),
          isDense: true,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                width: 1,
                color: Colors.white,
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                width: 1,
                color: Colors.white,
              )),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              width: 1,
              color: Colors.white,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              width: 1.5,
              color: Colors.red,
            ),
          ),
          errorStyle: TextStyle(height: 0, fontSize: 0),
          labelStyle: TextStyle(
            fontFamily: globals.font_family,
            fontSize: 16,
            letterSpacing: 0.5,
            color: projectEstimatedReturnsNode.hasFocus
                ? Colors.green[500]
                : Colors.grey,
          ),
        ),
        validator: (String value) {
          if (value.isEmpty) {
            errCheck = true;
            return 'Estimated Returns is Required';
          }

          return null;
        },
        onSaved: (String newValue) {
          projectEstimatedReturns = double.parse(newValue);
        },
      ),
    );
  }

  Widget _buildProjectDuration() {
    return Material(
      borderRadius: BorderRadius.circular(30),
      elevation: 1,
      child: TextFormField(
        focusNode: projectDurationNode,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelText: 'Project Duration(weeks)',
          hintStyle: TextStyle(
            fontFamily: globals.font_family,
            fontSize: 12,
            letterSpacing: 0,
            color: Colors.grey,
          ),
          contentPadding: new EdgeInsets.fromLTRB(20, 20, 0, 20),
          isDense: true,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                width: 1,
                color: Colors.white,
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                width: 1,
                color: Colors.white,
              )),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              width: 1,
              color: Colors.white,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              width: 1.5,
              color: Colors.red,
            ),
          ),
          errorStyle: TextStyle(height: 0, fontSize: 0),
          labelStyle: TextStyle(
            fontFamily: globals.font_family,
            fontSize: 16,
            letterSpacing: 0.5,
            color:
                projectDurationNode.hasFocus ? Colors.green[500] : Colors.grey,
          ),
        ),
        validator: (String value) {
          if (value.isEmpty) {
            errCheck = true;
            return 'Project Duration is Required';
          }

          return null;
        },
        onSaved: (String newValue) {
          projectDuration = int.parse(newValue);
        },
      ),
    );
  }

  Widget _buildProjectRequiredAmount() {
    return Material(
      borderRadius: BorderRadius.circular(30),
      elevation: 1,
      child: TextFormField(
        focusNode: projectRequiredAmountNode,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelText: 'Required Amount(\$)',
          hintStyle: TextStyle(
            fontFamily: globals.font_family,
            fontSize: 12,
            letterSpacing: 0,
            color: Colors.grey,
          ),
          contentPadding: new EdgeInsets.fromLTRB(20, 20, 0, 20),
          isDense: true,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                width: 1,
                color: Colors.white,
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                width: 1,
                color: Colors.white,
              )),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              width: 1,
              color: Colors.white,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              width: 1.5,
              color: Colors.red,
            ),
          ),
          errorStyle: TextStyle(height: 0, fontSize: 0),
          labelStyle: TextStyle(
            fontFamily: globals.font_family,
            fontSize: 16,
            letterSpacing: 0.5,
            color: projectRequiredAmountNode.hasFocus
                ? Colors.green[500]
                : Colors.grey,
          ),
        ),
        validator: (String value) {
          if (value.isEmpty) {
            errCheck = true;
            return 'Project Required Amount is Required';
          }

          return null;
        },
        onSaved: (String newValue) {
          projectRequiredAmount = double.parse(newValue);
        },
      ),
    );
  }

  Widget _buildProjectPercentageReturns() {
    return Material(
      borderRadius: BorderRadius.circular(30),
      elevation: 1,
      child: TextFormField(
        focusNode: projectPercentageReturnsNode,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelText: 'Investor Returns(%)',
          hintStyle: TextStyle(
            fontFamily: globals.font_family,
            fontSize: 12,
            letterSpacing: 0,
            color: Colors.grey,
          ),
          contentPadding: new EdgeInsets.fromLTRB(20, 20, 0, 20),
          isDense: true,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                width: 1,
                color: Colors.white,
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                width: 1,
                color: Colors.white,
              )),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              width: 1,
              color: Colors.white,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              width: 1.5,
              color: Colors.red,
            ),
          ),
          errorStyle: TextStyle(height: 0, fontSize: 0),
          labelStyle: TextStyle(
            fontFamily: globals.font_family,
            fontSize: 16,
            letterSpacing: 0.5,
            color: projectPercentageReturnsNode.hasFocus
                ? Colors.green[500]
                : Colors.grey,
          ),
        ),
        validator: (String value) {
          if (value.isEmpty) {
            errCheck = true;
            return 'Profit Percentage is Required';
          }

          return null;
        },
        onSaved: (String newValue) {
          projectPercentageReturns = double.parse(newValue);
        },
      ),
    );
  }

  Widget _buildProjectType() {
    return Material(
      borderRadius: BorderRadius.circular(30),
      elevation: 1,
      child: TextFormField(
        focusNode: projectTypeNode,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelText: 'Project Type',
          hintStyle: TextStyle(
            fontFamily: globals.font_family,
            fontSize: 14,
            letterSpacing: 1,
            color: Colors.grey,
          ),
          contentPadding: new EdgeInsets.fromLTRB(20, 20, 0, 20),
          isDense: true,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                width: 1,
                color: Colors.white,
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                width: 1,
                color: Colors.white,
              )),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              width: 1,
              color: Colors.grey,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              width: 1.5,
              color: Colors.red,
            ),
          ),
          errorStyle: TextStyle(height: 0, fontSize: 0),
          labelStyle: TextStyle(
            fontFamily: globals.font_family,
            fontSize: 16,
            letterSpacing: 1,
            color: projectTypeNode.hasFocus ? Colors.green[500] : Colors.grey,
          ),
        ),
        validator: (String value) {
          if (value.isEmpty) {
            errCheck = true;
            return 'Project type is Required';
          }

          return null;
        },
        onSaved: (String newValue) {
          projectType = newValue;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green[500],
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.green[500],
          title: Text(
            'Create Farm Project',
            style: TextStyle(
              fontFamily: globals.font_family,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () async {
                setState(() {
                  check = 0;
                });
                _showLoadingDialog();
                if (!_formKey.currentState.validate()) {
                  setState(() {
                    check = 1;
                    Navigator.of(context).pop();
                  });
                  _showErrDialog('Enter all required fields.');
                  return;
                }

                _formKey.currentState.save();
                project = new Project(
                    detail: projectdetail,
                    duration: projectDuration,
                    estimatedReturns: projectEstimatedReturns,
                    farmID: widget.farmID,
                    percentageReturns: projectPercentageReturns,
                    requiredAmount: projectRequiredAmount,
                    type: "investment");
                result = await FarmController().createFarmProject(project);
                setState(() {
                  check = 1;
                  Navigator.of(context).pop();
                });
                if (result['value'] == globals.positive_status) {
                  _showSuccessDialog();
                } else {
                  _showErrDialog(result['data']);
                }
                return;
              },
              child: Row(
                children: <Widget>[
                  Text(
                    'SUBMIT',
                    style: TextStyle(color: Colors.white),
                  ),
                  Icon(
                    Icons.done_all,
                    color: Colors.white,
                  ),
                ],
              ),
            )
          ],
        ),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 30, 20, 20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Material(
                      color: Colors.green[500],
                      elevation: 3.0,
                      borderRadius: BorderRadius.circular(45),
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                            color: Colors.green[300],
                            borderRadius: BorderRadius.circular(45)),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Icon(
                                Icons.assignment,
                                size: 35,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              SizedBox(
                                child: _buildDetail(),
                                width: 250,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   height: 35,
                    // ),
                    // Material(
                    //   color: Colors.green[500],
                    //   elevation: 3.0,
                    //   borderRadius: BorderRadius.circular(45),
                    //   child: Container(
                    //     height: 60,
                    //     decoration: BoxDecoration(
                    //         color: Colors.green[300],
                    //         borderRadius: BorderRadius.circular(45)),
                    //     child: Padding(
                    //       padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.end,
                    //         children: <Widget>[
                    //           Icon(
                    //             Icons.beenhere,
                    //             size: 35,
                    //             color: Colors.white,
                    //           ),
                    //           SizedBox(
                    //             width: 5,
                    //           ),
                    //           SizedBox(
                    //             child: _buildProjectType(),
                    //             width: 250,
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: 35,
                    ),
                    Material(
                      color: Colors.green[500],
                      elevation: 3.0,
                      borderRadius: BorderRadius.circular(45),
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                            color: Colors.green[300],
                            borderRadius: BorderRadius.circular(45)),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Icon(
                                Icons.timer,
                                size: 35,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              SizedBox(
                                child: _buildProjectDuration(),
                                width: 250,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Material(
                      color: Colors.green[500],
                      elevation: 3.0,
                      borderRadius: BorderRadius.circular(45),
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                            color: Colors.green[300],
                            borderRadius: BorderRadius.circular(45)),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Icon(
                                Icons.monetization_on,
                                size: 35,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              SizedBox(
                                child: _buildProjectRequiredAmount(),
                                width: 250,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Material(
                      color: Colors.green[500],
                      elevation: 3.0,
                      borderRadius: BorderRadius.circular(45),
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                            color: Colors.green[300],
                            borderRadius: BorderRadius.circular(45)),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Icon(
                                Icons.attach_money,
                                size: 35,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              SizedBox(
                                child: _buildProjectEstimatedReturns(),
                                width: 250,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Material(
                      color: Colors.green[500],
                      elevation: 3.0,
                      borderRadius: BorderRadius.circular(45),
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                            color: Colors.green[300],
                            borderRadius: BorderRadius.circular(45)),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Icon(
                                Icons.insert_chart,
                                size: 35,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              SizedBox(
                                child: _buildProjectPercentageReturns(),
                                width: 250,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomBar());
  }
}
