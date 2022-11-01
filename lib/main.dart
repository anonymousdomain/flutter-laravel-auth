import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget? child;
  final bool _isAuth = false;
  @override
  void initState() {
    super.initState();
    
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.arrow_back),
          actions: const [
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Icon(Icons.message_rounded),
            )
          ],
          elevation: 0.0,
          backgroundColor: Colors.white54,
          foregroundColor: Colors.blue.withOpacity(0.8),
          title: const Text(
            'devo',
          ),
        ),
        body: child,
      ),
    );
  }
}
