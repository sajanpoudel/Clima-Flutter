import 'package:clima/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';

WeatherModel weatherModel =WeatherModel();

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});
  final locationWeather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  int condition;
  double tempr;
  String city;
  String weatherMessage;
  String weatherIcon;
  String weatherMessageFinal;
  void initState(){
    super.initState();
    updateUI(widget.locationWeather);
  }
  void updateUI(dynamic weatherdata){
    setState(() {
      if(weatherdata == null){
        tempr = 0;
        weatherMessageFinal = 'Location is not available';
        city ='';
        weatherIcon ='Error';
        print("null");
      }
      else{
  condition = weatherdata['weather'][0]['id'];
      tempr = weatherdata['main']['temp'];
      tempr = (tempr-273);
     city = weatherdata['name'];
     weatherMessage = weatherModel.getMessage(tempr.toInt());
     weatherMessageFinal ='$weatherMessage in $city';
     weatherIcon = weatherModel.getWeatherIcon(condition);
     print(tempr);
      }
     
    });
 

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: (){
                      setState(() async {
                        
                        var weatherData =await weatherModel.getLocationWeather();
                        updateUI(weatherData);
                      });
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: ()async {
                      var cityName = await Navigator.push(context, MaterialPageRoute(builder: (context)=>
                        CityScreen()
                        
                      ));
                      if(cityName != null){
                        var weatherData = await weatherModel.getCityWeather(cityName);
                      updateUI(weatherData);
                      }
                      

                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      tempr.toStringAsFixed(1),
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                   weatherMessageFinal,
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


 