import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
const kApiKey ='c9bee8996f8649c8497e7a94cf4fa170';

const openLocationMapUrl ='https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future <dynamic> getCityWeather(String cityName) async {
    String url = '$openLocationMapUrl?q=$cityName&&appid=$kApiKey';
    Networking networkHelper = Networking(url);
    var weatherData =await networkHelper.getData();
    return weatherData;
  }

  Future <dynamic> getLocationWeather() async{
      Location location = Location();
    await location.getCurrentLocation();
   
    Networking networkHelper = Networking('$openLocationMapUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$kApiKey');
     
     
     var weatherData = await networkHelper.getData();
     return weatherData;
  }
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
