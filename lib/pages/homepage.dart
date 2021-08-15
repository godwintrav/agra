import 'package:agraapp/pages/login.dart';
import 'package:agraapp/pages/register.dart';
import 'package:flutter/material.dart';
import 'package:agraapp/globals/globals.dart' as globals;

class Homepage extends StatelessWidget {
  const Homepage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[500],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 80, 20, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // Container(
                //   height: 100,
                //   width: 100,
                //   child: Image(
                //     image: AssetImage('assets/logo2.jpg'),
                //   ),
                // ),
                SizedBox(
                  height: 50,
                ),
                Center(
                  child: Text(
                    'Welcome To Agra',
                    style: TextStyle(
                      fontFamily: globals.font_family,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                ButtonTheme(
                  minWidth: MediaQuery.of(context).size.width,
                  height: 45.0,
                  child: RaisedButton(
                    elevation: 5,
                    color: Colors.green[300],
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Login(
                                    user_type: "farmer",
                                  )));
                    },
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.green[300], width: 2.0),
                        borderRadius: BorderRadius.circular(30)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Get started as a Farmer",
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
                    ),
                  ),
                ),
                // SizedBox(
                //   height: 50,
                // ),
                // ButtonTheme(
                //   minWidth: MediaQuery.of(context).size.width,
                //   height: 45.0,
                //   child: RaisedButton(
                //     elevation: 5,
                //     color: Colors.green[300],
                //     onPressed: () {
                //       Navigator.pushReplacement(
                //           context,
                //           MaterialPageRoute(
                //               builder: (context) => Login(
                //                     user_type: "grant",
                //                   )));
                //     },
                //     shape: RoundedRectangleBorder(
                //         side: BorderSide(color: Colors.green[300], width: 2.0),
                //         borderRadius: BorderRadius.circular(30)),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: <Widget>[
                //         Text(
                //           "Give a Grant",
                //           style: TextStyle(
                //             fontFamily: globals.font_family,
                //             fontSize: 15,
                //             fontWeight: FontWeight.bold,
                //             color: Colors.white,
                //             letterSpacing: 1,
                //           ),
                //         ),
                //         Icon(
                //           Icons.keyboard_arrow_right,
                //           size: 16,
                //           color: Colors.white,
                //         )
                //       ],
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: 50,
                ),
                ButtonTheme(
                  minWidth: MediaQuery.of(context).size.width,
                  height: 45.0,
                  child: RaisedButton(
                    elevation: 5,
                    color: Colors.green[300],
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Login(
                                    user_type: "investor",
                                  )));
                    },
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.green[300], width: 2.0),
                        borderRadius: BorderRadius.circular(30)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Get started as an Investor",
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
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
