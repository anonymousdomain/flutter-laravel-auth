import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lara_fl/screen/login_screen.dart';

import '../../helper/images.dart';

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Center(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                alignment: Alignment.topCenter,
                Images.freinds,
                fit: BoxFit.scaleDown,
                width: 200,
              ),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 40,
                child: Text(
                  'Time with Freinds',
                  style: TextStyle(color: Colors.indigo),
                ),
              ),
              ElevatedButton(
                  onPressed: () => Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: ((context) => LoginScreen()))),
                  child: Text('Get Started'))
            ],
          )),
        ),
      ),
    );
  }
}
