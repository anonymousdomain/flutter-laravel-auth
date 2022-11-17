
class Post {
  String? id;
  String title;
  String body;
  Post({this.id, required this.title,required this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        id: json['id'].toString(),
        title: json['name'].toString(),
        body: json['email'].toString());
  }
}
