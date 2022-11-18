import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lara_fl/helper/images.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

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
                Images.hit,
                fit: BoxFit.scaleDown,
                width: 200,
              ),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                  height: 40,
                  child: Text(
                    'Hit',
                    style: TextStyle(color: Colors.indigo),
                  ))
            ],
          )),
        ),
      ),
    );
  }
}
