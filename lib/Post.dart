class Post {
  final String userID;
  final String title;
  final String body;

  Post({
    required this.userID,
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userID: json['userId'],
      title: json['title'],
      body: json['body'],
    );
  }
}
