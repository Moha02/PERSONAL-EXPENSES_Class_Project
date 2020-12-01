import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Align(
                alignment: Alignment.topLeft,
                child: Material(
                    child: IconButton(
                        icon: Icon(
                          Icons.arrow_left,
                          size: 70,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        }))),
            SizedBox(
              height: 50,
            ),
            Center(
              child: Column(
                children: <Widget>[
                  Container(
                      height: 120.0,
                      width: 120.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/flutter-logo-round.png'),
                          fit: BoxFit.fill,
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                  Container(
                      height: 300,
                      width: 300,
                      // color: Colors.black,
                      child: Center(
                          child: Text(
                        "This is a Flutter app for Mobile Applcation class at UBT",
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                            decoration: TextDecoration.none),
                      ))),
                ],
              ),
            ),
          ],
        ));
  }
}
