import 'package:dsc_project/FUNCTIONS/GoogleLogin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ModalProgressHUD(
        inAsyncCall: _isLoading,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  image:
                      DecorationImage(image: AssetImage('assets/wallpaper.jpg'))),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              color: Colors.black.withOpacity(0.3),
            ),
            Name(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Container(
                  height: 40,
                  child: SignInButton(
                    Buttons.Google,
                    padding: EdgeInsets.only(left: 30.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    onPressed: () {
                      setState(() {
                        _isLoading = true;
                      });
                      GoogleLogin().googleLoginUser(context);
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// child: RaisedButton(
//   onPressed: () => Navigator.push(context, CupertinoPageRoute(builder: (context) => Home())),
//   child: Text('Next'),
// ),

class Name extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 70,
      right: 30,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text('NASA',
              textAlign: TextAlign.right,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  letterSpacing: 2,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'Montserrat')),
          SizedBox(height: 20),
          Text('Astronomy Picture of the Day',
              textAlign: TextAlign.right,
              style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 2,
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat')),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
