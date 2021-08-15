import 'package:agraapp/controllers/farm_controller.dart';
import 'package:agraapp/models/farm_class.dart';
import 'package:agraapp/pages/farmer/farmer_dashboard.dart';
import 'package:agraapp/pages/farmer/navigation_bar.dart';
import 'package:agraapp/pages/farmer/view_farms.dart';
import 'package:agraapp/pages/register.dart';
import 'package:flutter/material.dart';
import 'package:agraapp/globals/globals.dart' as globals;
import 'package:multi_image_picker/multi_image_picker.dart';

class CreateFarm extends StatefulWidget {
  @override
  _CreateFarmState createState() => _CreateFarmState();
}

class _CreateFarmState extends State<CreateFarm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _showDate = false;
  bool barrierVisible = false;
  FocusNode typeNode = new FocusNode();
  FocusNode titleNode = new FocusNode();
  FocusNode locationNode = new FocusNode();
  FocusNode dateEstNode = new FocusNode();
  String farmType;
  String farmTitle;
  String farmLocation;
  DateTime initial_date = DateTime.now();
  DateTime est_date = null;
  List<Asset> images = List<Asset>();
  dynamic err_msg;
  Map<String, dynamic> result;
  int check = 1;
  bool errCheck = false;
  Farm farm;

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
                Text('Farm Created Successfully'),
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
                          builder: (context) => ViewMyFarms(),
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

  Widget _buildTitle() {
    return Material(
      borderRadius: BorderRadius.circular(30),
      elevation: 1,
      child: TextFormField(
        focusNode: titleNode,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelText: 'Farm name',
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
            color: titleNode.hasFocus ? Colors.green[500] : Colors.grey,
          ),
        ),
        validator: (String value) {
          if (value.isEmpty) {
            errCheck = true;
            return 'Farm Title is Required';
          }

          return null;
        },
        onSaved: (String newValue) {
          farmTitle = newValue;
        },
      ),
    );
  }

  Widget _buildDateEst() {
    return Material(
      borderRadius: BorderRadius.circular(30),
      elevation: 1,
      child: TextFormField(
        onTap: () => _selectDate(context),
        enabled: false,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelText: "${est_date.toLocal()}".split(' ')[0],
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
          labelStyle: TextStyle(
            fontFamily: globals.font_family,
            fontSize: 18,
            letterSpacing: 1,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildLocation() {
    return Material(
      borderRadius: BorderRadius.circular(30),
      elevation: 1,
      child: TextFormField(
        focusNode: locationNode,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelText: 'Farm Location',
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
            color: locationNode.hasFocus ? Colors.green[500] : Colors.grey,
          ),
        ),
        validator: (String value) {
          if (value.isEmpty) {
            errCheck = true;
            return 'Location is Required';
          }

          return null;
        },
        onSaved: (String newValue) {
          farmLocation = newValue;
        },
      ),
    );
  }

  Widget _buildFarmType() {
    return Material(
      borderRadius: BorderRadius.circular(30),
      elevation: 1,
      child: TextFormField(
        focusNode: typeNode,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelText: 'Farm Type',
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
            color: typeNode.hasFocus ? Colors.green[500] : Colors.grey,
          ),
        ),
        validator: (String value) {
          if (value.isEmpty) {
            errCheck = true;
            return 'Farm type is Required';
          }

          return null;
        },
        onSaved: (String newValue) {
          farmType = newValue;
        },
      ),
    );
  }

  Widget _buildDisplayDate() {
    return Material(
      color: Colors.green[500],
      elevation: 3.0,
      borderRadius: BorderRadius.circular(45),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
            color: Colors.green[300], borderRadius: BorderRadius.circular(45)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Icon(
                Icons.date_range,
                size: 38,
                color: Colors.white,
              ),
              SizedBox(
                width: 5,
              ),
              SizedBox(
                child: _buildDateEst(),
                width: 250,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _showDateEst() {
    if (_showDate) {
      return Column(
        children: <Widget>[
          _buildDisplayDate(),
          SizedBox(
            height: 35,
          ),
        ],
      );
    }
    return Container();
  }

  Widget _buildAddImg() {
    return ButtonTheme(
      minWidth: MediaQuery.of(context).size.width,
      height: 60.0,
      child: RaisedButton(
        elevation: 5,
        color: Colors.white,
        onPressed: () => loadAssets(),
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.white, width: 2.0),
            borderRadius: BorderRadius.circular(30)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Select Farm Image",
              style: TextStyle(
                fontFamily: globals.font_family,
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.green[500],
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = '';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 1,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: 'chat'),
        materialOptions: MaterialOptions(
          actionBarColor: '#00a2ed',
          actionBarTitle: 'Choose Image',
          allViewTitle: 'All Photos',
          useDetailsView: false,
          selectCircleStrokeColor: '#000000',
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
      print(e);
    }

    if (!mounted) return;

    setState(() {
      if (error.isNotEmpty) {
        err_msg = "Error Uploading Image";
        check = -1;
      } else {
        check = 3;
      }
      images = resultList;
    });
  }

  Widget buildGridView() {
    return Column(
      children: <Widget>[
        GridView.count(
          crossAxisCount: 1,
          shrinkWrap: true,
          children: List.generate(images.length, (index) {
            Asset asset = images[index];
            return AssetThumb(
              asset: asset,
              width: 300,
              height: 300,
            );
          }),
        ),
        SizedBox(
          height: 35,
        ),
      ],
    );
  }

  Widget buildImgThumb() {
    if (images.length > 0) {
      return buildGridView();
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green[500],
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.green[500],
          title: Text('Create Farm'),
          actions: <Widget>[
            FlatButton(
              onPressed: () async {
                print(est_date.toString());
                setState(() {
                  check = 0;
                });
                _showLoadingDialog();
                if (!_formKey.currentState.validate() ||
                    est_date == null ||
                    images.length < 1) {
                  setState(() {
                    check = 1;
                    Navigator.of(context).pop();
                  });
                  _showErrDialog('Enter all required fields.');
                  return;
                }

                _formKey.currentState.save();
                farm = new Farm(
                    farmAttachments: images,
                    farmEstablishDate: est_date,
                    farmLocation: farmLocation,
                    farmTitle: farmTitle,
                    farmType: farmType,
                    farmerId: globals.user_info.id);
                result = await FarmController().createFarm(farm);
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
                                Icons.account_circle,
                                size: 40,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              SizedBox(
                                child: _buildTitle(),
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
                                Icons.location_on,
                                size: 40,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              SizedBox(
                                child: _buildLocation(),
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
                                Icons.toys,
                                size: 40,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              SizedBox(
                                child: _buildFarmType(),
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
                    ButtonTheme(
                      minWidth: MediaQuery.of(context).size.width,
                      height: 60.0,
                      child: RaisedButton(
                        elevation: 5,
                        color: Colors.white,
                        onPressed: () => _selectDate(context),
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white, width: 2.0),
                            borderRadius: BorderRadius.circular(30)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Select Farm Established Date",
                              style: TextStyle(
                                fontFamily: globals.font_family,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.green[500],
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    _showDateEst(),
                    _buildAddImg(),
                    SizedBox(
                      height: 35,
                    ),
                    buildImgThumb(),
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
