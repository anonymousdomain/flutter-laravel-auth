// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:lara_fl/providers/auth.dart';
import 'package:lara_fl/screen/login_screen.dart';

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
      }).then((value) => ScaffoldMessenger.of(context).showSnackBar(_snackBar));
      Navigator.pop(context);
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
      appBar: AppBar(
        title: Text('Register'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Stack(children: [
          Form(
            key: _formKey,
            child: Scrollbar(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: 'Name',
                          hintText: 'Your Name'),
                      controller: _name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return Provider.of<Auth>(context, listen: false)
                              .validationError
                              ?.name;
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: 'Email',
                          hintText: 'your@email.com'),
                      controller: _email,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return Provider.of<Auth>(context, listen: false)
                              .validationError
                              ?.email;
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: 'Password',
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
                      obscureText: Provider.of<Auth>(context).obscureText,
                      controller: _password,
                      autofocus: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return Provider.of<Auth>(context, listen: false)
                              .validationError
                              ?.password;
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: 'Password',
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
                      obscureText: Provider.of<Auth>(context).obscureText,
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
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: TextButton(
                          onPressed: () async {
                            await submit();
                          },
                          child: Text('Register')),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -10,
            left: 20,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('you already have account?'),
                TextButton(
                    onPressed: () => Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: ((context) => LoginScreen()))),
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.indigo),
                    ))
              ],
            ),
          )
        ]),
      ),
    );
  }
}
