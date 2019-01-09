import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:path/path.dart';
import 'package:stats/main.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen1 extends StatelessWidget {
  final Color primaryColor;
  final Color backgroundColor;
  final AssetImage backgroundImage;

  LoginScreen1(
      {Key key, this.primaryColor, this.backgroundColor, this.backgroundImage});

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: this.backgroundColor,
      ),
      child: Column(
//        crossAxisAlignment: CrossAxisAlignment.start,
//        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new ClipPath(
            clipper: MyClipper(),
            child: Container(
              decoration: BoxDecoration(
                image: new DecorationImage(
                  image: AssetImage("images/full-bloom.png"),
                  fit: BoxFit.cover,
                ),
              ),
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 220.0, bottom: 50.0),
              child: Column(
                children: <Widget>[
                  Text(
                    "POLLS",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: this.primaryColor),
                  ),
                  Text(
                    "providing needed data",
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: this.primaryColor),
                  ),
                ],
              ),
            ),
          ),
//          Padding(
//            padding: const EdgeInsets.only(left: 40.0),
//            child: Text(
//              "Email",
//              style: TextStyle(color: Colors.grey, fontSize: 16.0),
//            ),
//          ),
//          Container(
//            decoration: BoxDecoration(
//              border: Border.all(
//                color: Colors.grey.withOpacity(0.5),
//                width: 1.0,
//              ),
//              borderRadius: BorderRadius.circular(20.0),
//            ),
//            margin:
//            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//            child: Row(
//              children: <Widget>[
//                new Padding(
//                  padding:
//                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
//                  child: Icon(
//                    Icons.person_outline,
//                    color: Colors.grey,
//                  ),
//                ),
//                Container(
//                  height: 30.0,
//                  width: 1.0,
//                  color: Colors.grey.withOpacity(0.5),
//                  margin: const EdgeInsets.only(left: 00.0, right: 10.0),
//                ),
//                new Expanded(
//                  child: TextField(
//                    decoration: InputDecoration(
//                      border: InputBorder.none,
//                      hintText: 'Enter your email',
//                      hintStyle: TextStyle(color: Colors.grey),
//                    ),
//                  ),
//                )
//              ],
//            ),
//          ),
//          Padding(
//            padding: const EdgeInsets.only(left: 40.0),
//            child: Text(
//              "Password",
//              style: TextStyle(color: Colors.grey, fontSize: 16.0),
//            ),
//          ),
//          Container(
//            decoration: BoxDecoration(
//              border: Border.all(
//                color: Colors.grey.withOpacity(0.5),
//                width: 1.0,
//              ),
//              borderRadius: BorderRadius.circular(20.0),
//            ),
//            margin:
//            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//            child: Row(
//              children: <Widget>[
//                new Padding(
//                  padding:
//                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
//                  child: Icon(
//                    Icons.lock_open,
//                    color: Colors.grey,
//                  ),
//                ),
//                Container(
//                  height: 30.0,
//                  width: 1.0,
//                  color: Colors.grey.withOpacity(0.5),
//                  margin: const EdgeInsets.only(left: 00.0, right: 10.0),
//                ),
//                new Expanded(
//                  child: TextField(
//                    decoration: InputDecoration(
//                      border: InputBorder.none,
//                      hintText: 'Enter your password',
//                      hintStyle: TextStyle(color: Colors.grey),
//                    ),
//                  ),
//                )
//              ],
//            ),
//          ),
//          Container(
//            margin: const EdgeInsets.only(top: 20.0),
//            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
//            child: new Row(
//              children: <Widget>[
//                new Expanded(
//                  child: FlatButton(
//                    shape: new RoundedRectangleBorder(
//                        borderRadius: new BorderRadius.circular(30.0)),
//                    splashColor: this.primaryColor,
//                    color: this.primaryColor,
//                    child: new Row(
//                      children: <Widget>[
//                        new Padding(
//                          padding: const EdgeInsets.only(left: 20.0),
//                          child: Text(
//                            "LOGIN",
//                            style: TextStyle(color: Colors.white),
//                          ),
//                        ),
//                        new Expanded(
//                          child: Container(),
//                        ),
//                        new Transform.translate(
//                          offset: Offset(15.0, 0.0),
//                          child: new Container(
//                            padding: const EdgeInsets.all(5.0),
//                            child: FlatButton(
//                              shape: new RoundedRectangleBorder(
//                                  borderRadius:
//                                  new BorderRadius.circular(28.0)),
//                              splashColor: Colors.white,
//                              color: Colors.blue,
//                              child: Icon(
//                                Icons.arrow_forward,
//                                color: this.primaryColor,
//                              ),
//                              onPressed: () => {},
//                            ),
//                          ),
//                        )
//                      ],
//                    ),
//                    onPressed: () => {},
//                  ),
//                ),
//              ],
//            ),
//          ),
          Container(
            child: GestureDetector(
              onTap: () {
                initiateFacebookLogin(context);
              },
              child: Image.asset(
                "images/facebook.png",
                height: 180,
                width: 180,
              ),
            ),
          )
//          Container(
//            margin: const EdgeInsets.only(top: 20.0),
//            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
//            child: new Row(
//              children: <Widget>[
//                new Expanded(
//                  child: FlatButton(
//                    shape: new RoundedRectangleBorder(
//                        borderRadius: new BorderRadius.circular(30.0)),
//                    color: Colors.transparent,
//                    child: Container(
//                      padding: const EdgeInsets.only(left: 20.0),
//                      alignment: Alignment.center,
//                      child: Text(
//                        "DON'T HAVE AN ACCOUNT?",
//                        style: TextStyle(color: this.primaryColor),
//                      ),
//                    ),
//                    onPressed: () => {},
//                  ),
//                ),
//              ],
//            ),
//          ),
        ],
      ),
    );
  }

  void initiateFacebookLogin(BuildContext context) async {
    var facebookLogin = FacebookLogin();
    var facebookLoginResult =
        await facebookLogin.logInWithReadPermissions(['email']);
    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        print("Error");
        //   onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("CancelledByUser");
        //  onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.loggedIn:
        FirebaseAuth.instance.signInWithFacebook(accessToken: facebookLoginResult.accessToken.token);
        Navigator.pushReplacement(
          context,
          new MaterialPageRoute(
              builder: (context) => new Home()),
        );

        //onLoginStatusChanged(true);
        break;
    }
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p = new Path();
    p.lineTo(size.width, 0.0);
    p.lineTo(size.width, size.height * 0.85);
    p.arcToPoint(
      Offset(0.0, size.height * 0.85),
      radius: const Radius.elliptical(50.0, 10.0),
      rotation: 0.0,
    );
    p.lineTo(0.0, 0.0);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
