// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:lara_fl/main.dart';
import 'package:lara_fl/providers/auth.dart';
import 'package:lara_fl/screen/register.dart';
import 'package:lara_fl/widgets/custom_button.dart';
import 'package:lara_fl/widgets/custom_snack_bar.dart';
import 'package:lara_fl/widgets/custom_textformfiled.dart';

import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _email.text = 'dawityitagesu@gmail.com';
    _password.text = 'password';
  }

  Future submit() async {
    if (_formKey.currentState!.validate()) {
      await Provider.of<Auth>(context, listen: false).login(
          credential: {'email': _email.text, 'password': _password.text});

      ScaffoldMessenger.of(context).showSnackBar(
          customSnackBar(context, 'successfully logged in', false));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: ((context) => HomePage())));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(customSnackBar(context, 'faild to login ', true));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(children: [
            Text('Login Here',
                style: TextStyle(
                    color: Colors.indigo,
                    fontSize: 30,
                    fontWeight: FontWeight.bold)),
            SizedBox(
              height: 20,
            ),
            Form(
              key: _formKey,
              child: Scrollbar(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      CustomTextFormField(
                        email: _email,
                        label: 'Email',
                        hint: 'example@gmail.com',
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      CustomTextFormField(
                          email: _password,
                          hint: 'Enter Your Password',
                          label: 'Password'),
                      CustomButton(onTap: submit, title: 'Login')
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  child: Text("Don't you have an account yet?"),
                ),
                TextButton(
                    onPressed: () => Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: ((context) => Register()))),
                    child: Text(
                      'Register',
                      style: TextStyle(color: Colors.indigo),
                    ))
              ],
            )
          ]),
        ),
      ),
    );
  }
}
