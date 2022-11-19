import 'package:flutter/material.dart';
import 'package:lara_fl/providers/auth.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {Key? key,
      required TextEditingController email,
      required this.hint,
      required this.label})
      : _email = email,
        super(key: key);

  final TextEditingController _email;
  String label;
  String hint;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromRGBO(158, 158, 158, 1).withOpacity(0.2)),
      child: TextFormField(
        decoration: InputDecoration(
            suffixIcon: label == 'Password'
                ? GestureDetector(
                    onTap: () {
                      Provider.of<Auth>(context, listen: false).toggleText();
                    },
                    child: Icon(
                      Icons.toggle_off_rounded,
                      color: Colors.indigo,
                      size: 35,
                    ),
                  )
                : SizedBox.shrink(),
            border: InputBorder.none,
            labelText: label,
            hintText: hint),
        controller: _email,
        autofocus: true,
        autocorrect: true,
        validator: (value) {
          if (value == null || value.isEmpty) {
            if (label == 'Email') {
              return Provider.of<Auth>(context, listen: false)
                  .validationError
                  ?.email;
            } else if (label == 'Password') {
              return Provider.of<Auth>(context, listen: false)
                  .validationError
                  ?.password;
            } else {
              return Provider.of<Auth>(context, listen: false)
                  .validationError
                  ?.name;
            }
          } else {
            return null;
          }
        },
        obscureText: label == 'Password'
            ? Provider.of<Auth>(context).obscureText
            : false,
      ),
    );
  }
}
