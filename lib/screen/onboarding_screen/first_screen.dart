import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lara_fl/helper/images.dart';

class BuildPage extends StatelessWidget {
  BuildPage({super.key, required this.images, required this.text});
  String images;
  String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              alignment: Alignment.topCenter,
              images,
              fit: BoxFit.contain,
              width: 200,
            ),
            SizedBox(
              height: 40,
            ),
            SizedBox(
              height: 40,
              child: RichText(
                text: TextSpan(
                    text: text,
                    style: TextStyle(
                        color: Colors.indigo,
                        fontSize: 20,
                        fontWeight: FontWeight.w500)),
              ),
            )
          ],
        )),
      ),
    );
  }
}
