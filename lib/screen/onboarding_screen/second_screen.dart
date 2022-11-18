import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../helper/images.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

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
                Images.catchp,
                fit: BoxFit.scaleDown,
                width: 200,
              ),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 40,
                child: Text(
                  'Catch',
                  style: TextStyle(color: Colors.indigo),
                ),
              )
            ],
          )),
        ),
      ),
    );
  }
}
