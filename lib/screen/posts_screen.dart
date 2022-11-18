
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lara_fl/helper/dio.dart';
import 'package:dio/dio.dart' as Dio;
import '../models/post.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  final storage = FlutterSecureStorage();

  Future<List<Post>> getPosts() async {
    final token = await storage.read(key: 'auth');
    Dio.Response res = await dio().get('user/posts',
        options: Dio.Options(headers: {
          'Authorization': 'Bearer $token',
        }));
    List posts = res.data;
    return posts.map((post) => Post.fromJson(post)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('posts'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Center(
        child: FutureBuilder<List<Post>>(
            future: getPosts(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // log(snapshot.data!.first.body.toString());
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var item = snapshot.data![index];
                      return ListTile(
                        title: Text(item.title),
                        subtitle: Text(item.body),
                      );
                    });
              } else if (snapshot.hasError) {
                log(snapshot.error.toString());
                return Text('faild to load posts');
              } else if (!snapshot.hasData) {
                return Text('no data');
              }
              return CircularProgressIndicator();
            }),
      ),
    );
  }
}
