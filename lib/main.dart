import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_styling_flutter/data/api.dart';
import 'package:weather_styling_flutter/utils.dart';

import 'data/weather.dart';

void main() async {
  await dotenv.load(fileName: 'assets/env/.env');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> clothes = [
    'assets/img/shirts.png',
    'assets/img/short.png',
    'assets/img/pants.png',
  ];

  List<String> sky = [
    'assets/img/sky1.png',
    'assets/img/sky2.png',
    'assets/img/sky3.png',
    'assets/img/sky4.png',
  ];

  List<String> status = [
    '날이 아주 좋아요!',
    '산책하기 좋아요',
    '오늘은 흐리네요',
    '우산을 꼭 챙기세요',
  ];

  // Color(oxFF00aaff)
  List<Color> colors = const [
    Color(0xFFf78144),
    Color(0xFF1d9fea),
    Color(0xFF523de4),
    Color(0xFF587d9a),
  ];

  int level = 0;
  List<Weather> weather = [];
  late Weather current;

  void getWeather() async {
    final api = WeatherApi();
    weather = await api.getWeather(1, 1, 20220113, '2030');

    final now = DateTime.now();

    int time = int.parse('${now.hour}30');
    weather.removeWhere((w) => w.time < time);
    current = weather.first;

    level = getLevel(current);

    setState(() {});
  }

  int getLevel(Weather w) {
    if (w.sky > 8) {
      return 3;
    } else if (w.sky > 5) {
      return 2;
    } else if (w.sky > 2) {
      return 1;
    }
    return 0;
  }

  @override
  void initState() {
    super.initState();
    getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors[level],
      body: weather.isEmpty
          ? const Text('날씨 정보를 불러오고 있어요')
          : Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(height: 50),
                  Text('중구', textAlign: TextAlign.center, style: TextStyle(fontSize: 20, color: Colors.white)),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    width: 100,
                    height: 100,
                    alignment: Alignment.centerRight,
                    child: Image.asset(sky[level]),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('${current.t1h} °C', style: TextStyle(fontSize: 28, color: Colors.white)),
                      Column(
                        children: [
                          Text(
                              // '${Utils.stringToDateTime(current.date).year}년 '
                              '${Utils.stringToDateTime(current.date).month}월 '
                              '${Utils.stringToDateTime(current.date).day}일',
                              style: TextStyle(fontSize: 14, color: Colors.white)),
                          Text(status[level], style: TextStyle(fontSize: 14, color: Colors.white)),
                        ],
                      ),
                    ],
                  ),
                  Container(height: 30),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text('오늘 어울리는 복장을 추천해드려요', style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(clothes.length, (idx) {
                      return Container(
                        padding: const EdgeInsets.all(8),
                        width: 100,
                        height: 100,
                        child: Image.asset(clothes[idx], fit: BoxFit.contain),
                      );
                    }),
                  ),
                  Container(height: 30),
                  Expanded(
                    child: Container(
                      height: 150,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: List.generate(weather.length, (idx) {
                          final w = weather[idx];
                          int _level = getLevel(w);

                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('${w.t1h} °C', style: TextStyle(fontSize: 10, color: Colors.white)),
                                Text('${w.wsd} m/s', style: TextStyle(fontSize: 10, color: Colors.white)),
                                Container(
                                  width: 50,
                                  height: 50,
                                  alignment: Alignment.centerRight,
                                  child: Image.asset(sky[level]),
                                ),
                                Text(
                                  '${w.time}',
                                  style: TextStyle(fontSize: 10, color: Colors.white),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                  Container(height: 80),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {},
      ),
    );
  }
}
