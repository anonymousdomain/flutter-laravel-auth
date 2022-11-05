import 'package:flutter/material.dart';
import 'package:lara_fl/widgets/login_screen.dart';
import 'package:lara_fl/widgets/posts_screen.dart';
import 'package:lara_fl/widgets/register.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Consumer<Auth>(
        builder: ((context, auth, child) {
          if (auth.authenticated) {
            return ListView(
              children: [
                ListTile(
                  title: Text(auth.user?.email ?? ''),
                ),
                ListTile(
                  title: Text('posts'),
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => PostsScreen()))),
                ),
                ListTile(
                    title: Text('logout'),
                    onTap: () {
                      Provider.of<Auth>(context, listen: false).logout();
                      Navigator.pop(context);
                    }),
              ],
            );
          } else {
            return ListView(
              children: [
                ListTile(
                    title: Text('register'),
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: ((context) => Register())))),
                ListTile(
                  title: Text('Login'),
                  onTap: (() => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => LoginScreen())))),
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}
