

import 'package:project/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:project/services/location.dart';
import 'package:project/services/networking.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../services/location.dart';
import '../services/networking.dart';


const apiKey = '59946d09ad03fa13e767929ce112f3b0';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';


class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  double latitude;
  double longitude;
  @override
  void initState(){
    super.initState();
    getLocationData();
  }


  void getLocationData() async{
    Location location = Location();
    await location.getCurrentLocation();
    latitude = location.latitude;
    longitude = location.longitude;

   
    NetworkHelper networkHelper = NetworkHelper('$openWeatherMapURL?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric');
    var weatherData = await networkHelper.getData();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MyHomePage(locationWeather: weatherData,);
    }));


  }
  @override
  Widget build(BuildContext context) {

    
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SpinKitFadingCube (
          color: Colors.red,
          size: 60.0,
          
        ),),
    );
  }
}
