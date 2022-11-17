import 'package:flutter/material.dart';
import 'package:lara_fl/providers/auth.dart';
import 'package:lara_fl/widgets/posts_screen.dart';

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
  final SnackBar _snackBar = SnackBar(
    content: Text('successfully logged in '),
    duration: Duration(seconds: 2),
  );
  final SnackBar _snackBarError = SnackBar(
    content: Text('faild to login'),
    duration: Duration(seconds: 2),
  );
  @override
  void initState() {
    super.initState();
    _email.text = 'dawityitagesu@gmail.com';
    _password.text = 'password';
  }

  Future submit() async {
    if (_formKey.currentState!.validate()) {
      await Provider.of<Auth>(context, listen: false).login(credential: {
        'email': _email.text,
        'password': _password.text
      }).then((value) => Navigator.pushReplacement(
          context, MaterialPageRoute(builder: ((context) => PostsScreen()))));
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(_snackBar);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(_snackBarError);
    }
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
                  width: MediaQuery.of(context).size.width,
                  child: TextButton(
                      onPressed: () async {
                        await submit();
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
