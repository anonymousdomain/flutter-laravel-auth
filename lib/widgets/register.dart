import 'package:flutter/material.dart';
import 'package:lara_fl/providers/auth.dart';

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

  void submit() async {
    Provider.of<Auth>(context, listen: false).register(credential: {
      'name': _name.text,
      'email': _email.text,
      'password': _password.text
    });

    Navigator.pop(context);
    // Navigator.push(
    //     context, MaterialPageRoute(builder: ((context) => PostsScreen())));
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
                      labelText: 'Name',
                      hintText: 'Your Name'),
                  controller: _name,
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
                        Provider.of<Auth>(context, listen: false).toggleText();
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
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: TextButton(onPressed: submit, child: Text('Register')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
