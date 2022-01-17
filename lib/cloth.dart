import 'package:flutter/material.dart';
import 'package:weather_styling_flutter/data/weather.dart';

import 'data/preference.dart';

class ClothPage extends StatefulWidget {
  const ClothPage({Key? key}) : super(key: key);

  @override
  _ClothPageState createState() => _ClothPageState();
}

class _ClothPageState extends State<ClothPage> {
  List<ClothTemperature> clothes = [];

  List<List<String>> sets = [
    ['assets/img/jumper.png', 'assets/img/long.png', 'assets/img/short.png'],
    ['assets/img/jumper1.png', 'assets/img/skirts1.png', 'assets/img/shirts1.png'],
    ['assets/img/shirts.png', 'assets/img/short.png', 'assets/img/pants.png'],
    ['assets/img/shirts.png', 'assets/img/short.png', 'assets/img/pants.png'],
    ['assets/img/shirts.png', 'assets/img/long.png', 'assets/img/pants.png'],
    ['assets/img/jumper.png', 'assets/img/long.png', 'assets/img/pants.png'],
  ];

  void getCloth() async {
    final pref = Preference();
    clothes = await pref.getTemperature();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getCloth();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: List.generate(clothes.length, (idx) {
          return InkWell(
            child: Column(
              children: [
                Text('${clothes[idx].temperature} °C'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(clothes[idx].cloth.length, (_idx) {
                    return Container(
                      padding: const EdgeInsets.all(8),
                      width: 100,
                      height: 100,
                      child: Image.asset(clothes[idx].cloth[_idx], fit: BoxFit.contain),
                    );
                  }),
                ),
              ],
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (ctx) {
                  return AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(sets.length, (_idx) {
                        return InkWell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: List.generate(sets[_idx].length, (__idx) {
                              return Container(
                                padding: const EdgeInsets.all(8),
                                width: 50,
                                height: 50,
                                child: Image.asset(sets[_idx][__idx], fit: BoxFit.contain),
                              );
                            }),
                          ),
                          onTap: () async {
                            clothes[idx].cloth = sets[_idx];
                            final pref = Preference();
                            await pref.setTemperature(clothes[idx]);
                            Navigator.of(context).pop();
                            setState(() {});
                          },
                        );
                      }),
                    ),
                    actions: [
                      TextButton(
                        child: const Text('닫기'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          );
        }),
      ),
    );
  }
}
