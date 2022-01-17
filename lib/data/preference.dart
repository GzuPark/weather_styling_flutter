import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_styling_flutter/data/weather.dart';

class Preference {
  Future<List<ClothTemperature>> getTemperature() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    List<String> temperature30 = pref.getStringList('30') ??
        [
          'assets/img/shirts.png',
          'assets/img/short.png',
          'assets/img/pants.png',
        ];
    List<String> temperature20 = pref.getStringList('20') ??
        [
          'assets/img/shirts.png',
          'assets/img/short.png',
          'assets/img/pants.png',
        ];
    List<String> temperature10 = pref.getStringList('10') ??
        [
          'assets/img/shirts.png',
          'assets/img/long.png',
          'assets/img/pants.png',
        ];
    List<String> temperature0 = pref.getStringList('0') ??
        [
          'assets/img/jumper.png',
          'assets/img/long.png',
          'assets/img/pants.png',
        ];
    List<String> temperatureM10 = pref.getStringList('-10') ??
        [
          'assets/img/jumper.png',
          'assets/img/long.png',
          'assets/img/pants.png',
        ];
    List<String> temperatureM20 = pref.getStringList('-20') ??
        [
          'assets/img/jumper.png',
          'assets/img/long.png',
          'assets/img/pants.png',
        ];

    return [
      ClothTemperature(temperature: 30, cloth: temperature30),
      ClothTemperature(temperature: 20, cloth: temperature20),
      ClothTemperature(temperature: 10, cloth: temperature10),
      ClothTemperature(temperature: 0, cloth: temperature0),
      ClothTemperature(temperature: -10, cloth: temperatureM10),
      ClothTemperature(temperature: -20, cloth: temperatureM20),
    ];
  }

  Future<void> setTemperature(ClothTemperature cloth) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setStringList('${cloth.temperature}', cloth.cloth);
  }
}
