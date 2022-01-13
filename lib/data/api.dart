import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:weather_styling_flutter/data/weather.dart';
import 'dart:convert';
import 'package:collection/collection.dart';

class WeatherApi {
  final String basUrl = dotenv.env['BASE_URL'].toString();
  final String endpoint = dotenv.env['ENDPOINT'].toString();
  final String apiKey = dotenv.env['API_KEY'].toString();

  Future<List<Weather>> getWeather(int x, int y, int date, String baseTime) async {
    String url = '$basUrl/$endpoint/'
        'getUltraSrtFcst?'
        'serviceKey=$apiKey'
        '&pageNo=1'
        '&numOfRows=1000'
        '&dataType=json'
        '&base_date=$date'
        '&base_time=$baseTime'
        '&nx=$x'
        '&ny=$y';

    // https://stackoverflow.com/a/66473447/7703502
    // http 0.13.0 부터 compile-time type safety 향상을 위해 아래와 같이 parsing 해줘야 함
    final response = await http.get(Uri.parse(url));

    List<Weather> weather = [];

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);

      var res = json.decode(body) as Map<String, dynamic>;

      List<dynamic> _data = [];

      _data = res['response']['body']['items']['item'] as List<dynamic>;

      final data = groupBy(_data, (obj) => '${(obj as dynamic)['fcstTime']}').entries.toList();
      for (final _r in data) {
        final _data = {
          'fcstTime': _r.key,
          'fcstDate': _r.value.first['fcstDate'],
        };

        for (final _d in _r.value) {
          _data[_d['category']] = _d['fcstValue'];
        }

        final w = Weather.fromJson(_data);
        weather.add(w);
      }

      return weather;
    } else {
      return [];
    }
  }
}
