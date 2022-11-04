import 'package:flutter/material.dart';
import 'package:lara_fl/providers/auth.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  @override
  void initState() {
    super.initState();
    _email.text = 'dawityitagesu@gmail.com';
    _password.text = 'password';
  }

  void submit() async {
    Provider.of<Auth>(context, listen: false)
        .login(credential: {'email': _email.text, 'password': _password.text});
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('login'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Form(
        child: Scrollbar(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: 'Email',
                      hintText: 'your@email.com'),
                  controller: _email,
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: 'Password'),
                  controller: _password,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: TextButton(
                      onPressed: () {
                        submit();
                      },
                      child: Text('Login')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
