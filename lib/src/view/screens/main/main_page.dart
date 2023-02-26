import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import 'widgets/city_weather_list.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool sm = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),

                  // AnimatedTextKit(
                  //   animatedTexts: [
                  //     TyperAnimatedText(
                  //       'What is\nthe weather like',
                  //       textStyle: const TextStyle(
                  //           color: Pallet.grey,
                  //           fontSize: 30,
                  //           fontWeight: FontWeight.w700),
                  //       speed: const Duration(milliseconds: 300),
                  //     ),
                  //   ],
                  //   totalRepeatCount: 1,
                  //   onFinished: () {
                  //     setState(() {
                  //       sm = true;
                  //     });
                  //   },
                  //   pause: const Duration(milliseconds: 1000),
                  //   displayFullTextOnTap: true,
                  //   stopPauseOnTap: true,
                  // ),
                  AnimatedTextKit(
                    animatedTexts: [
                      TyperAnimatedText(
                        'today',
                        textStyle: const TextStyle(
                            fontSize: 54, fontWeight: FontWeight.w700),
                        speed: const Duration(milliseconds: 300),
                      ),
                    ],
                    totalRepeatCount: 1,
                    pause: const Duration(milliseconds: 1000),
                    displayFullTextOnTap: true,
                    stopPauseOnTap: true,
                  ),
                  // Text(
                  //   "What is",
                  //   style: TextStyle(
                  //       color: Pallet.grey,
                  //       fontSize: 30,
                  //       fontWeight: FontWeight.w700),
                  // ),
                  // Text(
                  //   "the weather like",
                  //   style: TextStyle(
                  //       color: Pallet.grey,
                  //       fontSize: 30,
                  //       fontWeight: FontWeight.w700),
                  // ),
                  // Text(
                  //   "today?",
                  //   style: TextStyle(
                  //       // color: Pallet.grey,
                  //       fontSize: 54,
                  //       fontWeight: FontWeight.w700),
                  // ),
                ],
              ),
            ),
            const Divider(),
            const SizedBox(height: 30),
            const Expanded(child: CityWeatherList()),
          ],
        ),
      ),
    );
  }
}

