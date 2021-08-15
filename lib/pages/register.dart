import 'package:agraapp/controllers/user_controller.dart';
import 'package:agraapp/models/user_class.dart';
import 'package:agraapp/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:agraapp/globals/globals.dart' as globals;

class Register extends StatefulWidget {
  final String user_type;

  const Register({Key key, this.user_type}) : super(key: key);
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _showPassword = false;
  User user;
  String _password;
  FocusNode phoneNode = new FocusNode();
  FocusNode firstNode = new FocusNode();
  FocusNode lastNode = new FocusNode();
  FocusNode passwordNode = new FocusNode();
  String _phone;
  String _first_name;
  String _last_name;
  dynamic err_msg;
  dynamic result;
  int check = 1;

  Widget _buildFirstName() {
    return Material(
      borderRadius: BorderRadius.circular(30),
      elevation: 1,
      child: TextFormField(
        focusNode: firstNode,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelText: 'First name',
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
            color: firstNode.hasFocus ? Colors.green[500] : Colors.grey,
          ),
        ),
        validator: (String value) {
          if (value.isEmpty) {
            return 'First name is Required';
          }

          return null;
        },
        onSaved: (String newValue) {
          _first_name = newValue;
        },
      ),
    );
  }

  Widget _buildLastName() {
    return Material(
      borderRadius: BorderRadius.circular(30),
      elevation: 1,
      child: TextFormField(
        focusNode: lastNode,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelText: 'Last name',
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
            color: lastNode.hasFocus ? Colors.green[500] : Colors.grey,
          ),
        ),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Last name is Required';
          }

          return null;
        },
        onSaved: (String newValue) {
          _last_name = newValue;
        },
      ),
    );
  }

  Widget _buildPhone() {
    return Material(
      borderRadius: BorderRadius.circular(30),
      elevation: 1,
      child: TextFormField(
        focusNode: phoneNode,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelText: 'Phone Number',
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
            color: phoneNode.hasFocus ? Colors.green[500] : Colors.grey,
          ),
        ),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Phone Number is Required';
          }

          return null;
        },
        onSaved: (String newValue) {
          _phone = newValue;
        },
      ),
    );
  }

  Widget _buildPassword() {
    return Material(
      borderRadius: BorderRadius.circular(30),
      elevation: 1,
      child: TextFormField(
        focusNode: passwordNode,
        obscureText: !_showPassword,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
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
          labelText: 'Password',
          labelStyle: TextStyle(
            fontFamily: globals.font_family,
            fontSize: 16,
            letterSpacing: 1,
            color: passwordNode.hasFocus ? Colors.green[500] : Colors.grey,
          ),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _showPassword = !_showPassword;
              });
            },
            icon: Icon(Icons.remove_red_eye),
            color: this._showPassword ? Colors.red : Colors.grey,
          ),
        ),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Password is Required';
          }
          return null;
        },
        onSaved: (String newValue) {
          _password = newValue;
        },
      ),
    );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[500],
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 80, 20, 20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Text(
                        'Create your ' + widget.user_type + ' account',
                        style: TextStyle(
                          fontFamily: globals.font_family,
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25.0,
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
                                Icons.account_circle,
                                size: 40,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              SizedBox(
                                child: _buildFirstName(),
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
                                Icons.account_circle,
                                size: 40,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              SizedBox(
                                child: _buildLastName(),
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
                                Icons.phone_in_talk,
                                size: 40,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              SizedBox(
                                child: _buildPhone(),
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
                                Icons.lock,
                                size: 40,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              SizedBox(
                                child: _buildPassword(),
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
                      height: 50.0,
                      child: RaisedButton(
                        elevation: 5,
                        color: Colors.green[300],
                        onPressed: () async {
                          setState(() {
                            check = 0;
                          });
                          if (!_formKey.currentState.validate()) {
                            setState(() {
                              check = 1;
                            });
                            return;
                          }

                          _formKey.currentState.save();
                          user = new User(
                              phone: _phone,
                              firstName: _first_name,
                              lastName: _last_name,
                              password: _password,
                              userType: widget.user_type);
                          result = await UserController().registerUser(user);
                          if (result is int) {
                            if (widget.user_type == "farmer") {
                              Navigator.pushReplacementNamed(
                                  context, '/farmerDashboard');
                            } else {
                              Navigator.pushReplacementNamed(
                                  context, '/investorDashboard');
                            }
                          } else {
                            setState(() {
                              err_msg = result;
                              check = -1;
                            });
                          }
                        },
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Colors.green[300], width: 2.0),
                            borderRadius: BorderRadius.circular(30)),
                        child: (check != 0)
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Register",
                                    style: TextStyle(
                                      fontFamily: globals.font_family,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_right,
                                    size: 16,
                                    color: Colors.white,
                                  )
                                ],
                              )
                            : CircularProgressIndicator(),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login(
                                          user_type: widget.user_type,
                                        )));
                          },
                          splashColor: Colors.grey,
                          child: Text(
                            'Already have an account?, Login',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontFamily: globals.font_family,
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _buildCurrentState(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
