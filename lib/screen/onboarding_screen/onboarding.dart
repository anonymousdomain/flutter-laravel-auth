import 'package:flutter/material.dart';
import 'package:lara_fl/screen/login_screen.dart';
import 'package:lara_fl/screen/onboarding_screen/first_screen.dart';
import 'package:lara_fl/screen/onboarding_screen/second_screen.dart';
import 'package:lara_fl/screen/onboarding_screen/third_screen.dart';
import 'package:lara_fl/screen/register.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController? _controller;
  List<Widget> screens = [
    FirstScreen(),
    SecondScreen(),
    ThirdScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        controller: _controller,
        itemCount: screens.length,
        itemBuilder: ((context, pageindex) {
          return Stack(
            children: [
              screens[pageindex],
              Positioned(
                right: 25,
                top: MediaQuery.of(context).size.height * 0.35,
                child: Column(
                  children: List.generate(3, (index) {
                    return Padding(
                      padding: EdgeInsets.all(2),
                      child: Container(
                        width: 8,
                        height: pageindex == index ? 25 : 8,
                        decoration: BoxDecoration(
                            color: pageindex == index
                                ? Colors.indigo
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    );
                  }),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
