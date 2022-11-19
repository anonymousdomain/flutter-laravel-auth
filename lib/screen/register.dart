// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:lara_fl/main.dart';
import 'package:lara_fl/providers/auth.dart';
import 'package:lara_fl/screen/login_screen.dart';
import 'package:lara_fl/widgets/custom_button.dart';
import 'package:lara_fl/widgets/custom_textformfiled.dart';

import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _passwordConfirm = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final SnackBar _snackBar = SnackBar(
    content: Text('successfully registerd in '),
    duration: Duration(seconds: 2),
  );
  final SnackBar _snackBarError = SnackBar(
    content: Text('faild to register'),
    duration: Duration(seconds: 2),
  );
  Future submit() async {
    if (_formKey.currentState!.validate()) {
      await Provider.of<Auth>(context, listen: false).register(credential: {
        'name': _name.text,
        'email': _email.text,
        'password': _password.text,
        // 'password_confirm': _passwordConfirm.text
      });

      ScaffoldMessenger.of(context).showSnackBar(_snackBar);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: ((context) => HomePage())));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(_snackBarError);
    }
  }

  @override
  void initState() {
    super.initState();
    _email.text = 'who@gmail.com';
    _name.text = 'devo';
    _password.text = 'passme';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Text('Register Here',
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
                                email: _name,
                                hint: 'Enter Your Name',
                                label: 'Name'),
                            SizedBox(
                              height: 16,
                            ),
                            CustomTextFormField(
                                email: _email,
                                hint: 'example@gmail.com',
                                label: 'Email'),
                            SizedBox(
                              height: 16,
                            ),
                            CustomTextFormField(
                                email: _password,
                                hint: 'Enter Your Password',
                                label: 'Password'),
                            SizedBox(
                              height: 16,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 2),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color.fromRGBO(158, 158, 158, 1)
                                      .withOpacity(0.2)),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'PasswordConfirm',
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      Provider.of<Auth>(context, listen: false)
                                          .toggleText();
                                    },
                                    child: Icon(
                                      Icons.toggle_off_rounded,
                                      color: Colors.indigo,
                                      size: 35,
                                    ),
                                  ),
                                ),
                                obscureText:
                                    Provider.of<Auth>(context).obscureText,
                                controller: _passwordConfirm,
                                autofocus: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'password confirm field is required';
                                  }
                                  if (value != _password.text) {
                                    return 'The Password You Enterd Does not match';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            CustomButton(onTap: submit, title: 'Register')
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('you already have account?'),
                TextButton(
                    onPressed: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => LoginScreen()))),
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.indigo),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
