import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import '../widgets/navdrawer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController? _pageController;
  int pageINdex = 1;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: pageINdex);
  }

  onPageChanged(int page) {
    setState(() {
      pageINdex = page;
    });
  }

  onPageTap(int page) {
    _pageController!.animateToPage(page,
        duration: Duration(microseconds: 200), curve: Curves.linearToEaseOut);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text('welcome'),
      ),
      drawer: NavDrawer(),
      body: PageView(
        onPageChanged: onPageChanged,
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Container(
            child: Center(
              child: Text('hello1'),
            ),
          ),
          Container(
            child: Center(
              child: Text('hello12'),
            ),
          ),
          Container(
            child: Center(
              child: Text('hello13'),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CupertinoTabBar(
          onTap: onPageTap,
          currentIndex: pageINdex,
          activeColor: Colors.indigo,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                FeatherIcons.alignCenter,
                size: 30,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                FeatherIcons.plusCircle,
                size: 30,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                FeatherIcons.aperture,
                size: 30,
              ),
            ),
          ]),
    );
  }
}
