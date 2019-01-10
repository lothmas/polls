import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:path/path.dart';
import 'package:stats/facebook_custom.dart';
import 'package:stats/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';

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
        color: Colors.white24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
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
                  Image.asset(
                    "images/trending.png",
                    height: 50,
                    width: 50,
                  ),
                  Container(
                    height: 18,
                  ),
                  Text(
                    "POLLS",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: this.primaryColor),
                  ),
                  Container(
                    height: 15,
                  ),
                  Text(
                    "providing needed data",
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal,
                        color: this.primaryColor),
                  ),
                ],
              ),
            ),
          ),
          Container(
           child:Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
               TwitterSignInButton(onPressed: () {
                 twitterLogin.authorize().then((result) {
                   switch (result.status) {
                     case TwitterLoginStatus.loggedIn:
                       FirebaseAuth.instance
                           .signInWithTwitter(
                           authToken: result.session.token,
                           authTokenSecret: result.session.secret
                       );

                         Navigator.pushReplacement(
                           context,
                           new MaterialPageRoute(
                               builder: (context) => new Home()),
                         );

                       break;

                     case TwitterLoginStatus.cancelledByUser:
                       print('Cancelled by you');
                       break;

                     case TwitterLoginStatus.error:
                       print('Error');
                       break;
                   }
                 }).catchError((e) {
                   print(e);
                 });}),
               GoogleSignInButton(onPressed: () {initiateGoogleLogin(context);}),
               FacebookSignInButton1(onPressed: () {initiateFacebookLogin(context);}),
//               GoogleSignInButton(onPressed: () {}, darkMode: true),
             ],
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

//  Future<void> initiateGoogleLogin(BuildContext context) async {
//    try {
//      GoogleSignInAccount result=  await _googleSignIn.signIn();
//
//      String sad="sad";
//    } catch (error) {
//      print(error);
//    }
//  }


  void initiateGoogleLogin(BuildContext context)  async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
    await googleUser.authentication;
    final FirebaseUser user = await
    FirebaseAuth.instance.signInWithGoogle(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    Navigator.pushReplacement(
      context,
      new MaterialPageRoute(
          builder: (context) => new Home()),
    );
    // do something with signed-in user
  }

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  static final TwitterLogin twitterLogin = new TwitterLogin(
    consumerKey: 'kkOvaF1Mowy4JTvCxKTV5O1WF',
    consumerSecret: 'ZECGsI6UUDBEUVGkJe4S5vd0FGqGxC3wMJCgsXgPRfjSwRFnyH',
  );

  void initiateTwitterLogin(BuildContext context) async {
    final TwitterLoginResult result = await twitterLogin.authorize();
    String newMessage;

    switch (result.status) {
      case TwitterLoginStatus.loggedIn:
        final FirebaseUser user = await
        FirebaseAuth.instance.signInWithTwitter(
            authToken: result.session.token ,
            authTokenSecret: result.session.secret);
        Navigator.pushReplacement(
          context,
          new MaterialPageRoute(
              builder: (context) => new Home()),
        );
        break;
      case TwitterLoginStatus.cancelledByUser:
        newMessage = 'Login cancelled by user.';
        break;
      case TwitterLoginStatus.error:
        newMessage = 'Login error: ${result.errorMessage}';
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
