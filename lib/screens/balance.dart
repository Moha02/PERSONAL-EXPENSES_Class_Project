import 'package:flutter/material.dart';

class Balance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
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
                height: 10,
              ),
              Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 120.0,
                      width: 120.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/flutter1.jpg'),
                          fit: BoxFit.fill,
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        height: 200,
                        width: 150,
                        color: Colors.black,
                        child: Center(
                            child: Text(
                          "1000",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              decoration: TextDecoration.none),
                        ))),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
