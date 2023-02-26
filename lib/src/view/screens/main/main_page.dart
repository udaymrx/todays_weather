import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';

import '../../../controller/weather_controller.dart';
import '../../../core/pallet/pallet.dart';
import 'widgets/city_weather_list.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage>
    with SingleTickerProviderStateMixin {
  bool aliveToday = false;
  bool aliveQuestion = false;

  late AnimationController controller;
  late SequenceAnimation sequenceAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this);

    initializeList();

    sequenceAnimation = SequenceAnimationBuilder()
        .addAnimatable(
            animatable: Tween<double>(begin: 1.0, end: 0.0),
            from: Duration.zero,
            to: const Duration(milliseconds: 600),
            curve: Curves.ease,
            tag: "opacity")
        .addAnimatable(
            animatable: Tween<double>(begin: 240.0, end: -60.0),
            from: const Duration(milliseconds: 700),
            to: const Duration(milliseconds: 2000),
            curve: Curves.ease,
            tag: "today-top")
        .addAnimatable(
            animatable: Tween<double>(begin: 800.0, end: 100.0),
            from: const Duration(milliseconds: 2000),
            to: const Duration(milliseconds: 3200),
            curve: Curves.ease,
            tag: "list-top")
        .animate(controller);
  }

  void initializeList() {
    ref.read(weatherListProvider);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
          animation: controller,
          builder: (context, Widget? child) {
            return SafeArea(
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Positioned(
                    left: 30,
                    top: sequenceAnimation['today-top'].value,
                    height: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Opacity(
                          opacity: sequenceAnimation['opacity'].value,
                          child: AnimatedTextKit(
                            animatedTexts: [
                              TyperAnimatedText(
                                'What is\nthe weather like',
                                textStyle: const TextStyle(
                                    color: Pallet.grey,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w700),
                                speed: const Duration(milliseconds: 300),
                              ),
                            ],
                            totalRepeatCount: 1,
                            onFinished: () {
                              setState(() {
                                aliveToday = true;
                              });
                            },
                            displayFullTextOnTap: true,
                            stopPauseOnTap: true,
                          ),
                        ),
                        if (aliveToday)
                          Row(
                            children: [
                              AnimatedTextKit(
                                animatedTexts: [
                                  TyperAnimatedText(
                                    'today',
                                    textStyle: const TextStyle(
                                        fontSize: 54,
                                        fontWeight: FontWeight.w700),
                                    speed: const Duration(milliseconds: 300),
                                  ),
                                ],
                                totalRepeatCount: 1,
                                onFinished: () {
                                  setState(() {
                                    aliveQuestion = true;
                                  });
                                },
                                displayFullTextOnTap: true,
                                stopPauseOnTap: true,
                              ),
                              if (aliveQuestion)
                                Opacity(
                                  opacity: sequenceAnimation['opacity'].value,
                                  child: AnimatedTextKit(
                                    animatedTexts: [
                                      TyperAnimatedText(
                                        '?',
                                        textStyle: const TextStyle(
                                            fontSize: 54,
                                            fontWeight: FontWeight.w700),
                                        speed:
                                            const Duration(milliseconds: 300),
                                      ),
                                    ],
                                    totalRepeatCount: 1,
                                    onFinished: () {
                                      controller.forward();
                                    },
                                    displayFullTextOnTap: true,
                                    stopPauseOnTap: true,
                                  ),
                                ),
                            ],
                          ),
                      ],
                    ),
                  ),
                  Positioned.fill(
                    top: sequenceAnimation["list-top"].value,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: const <Widget>[
                        Divider(
                          thickness: 0.5,
                          height: 1,
                        ),
                        SizedBox(height: 20),
                        Expanded(child: CityWeatherList()),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
