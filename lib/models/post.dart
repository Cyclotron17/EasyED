// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

List<Post> postFromJson(String str) =>
    List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

String postToJson(List<Post> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post {
  String id;
  String userId;
  String post;
  String avatar;
  String content;
  bool isBlocked;
  String? postFormat;
  DateTime date;
  List<Like> likes;
  List<Comment> comments;
  int v;

  Post({
    required this.id,
    required this.userId,
    required this.post,
    required this.avatar,
    required this.content,
    required this.isBlocked,
    this.postFormat,
    required this.date,
    required this.likes,
    required this.comments,
    required this.v,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["_id"],
        userId: json["userId"],
        post: json["post"],
        avatar: json["avatar"],
        content: json["content"],
        isBlocked: json["isBlocked"],
        postFormat: json["postFormat"],
        date: DateTime.parse(json["date"]),
        likes: List<Like>.from(json["likes"].map((x) => Like.fromJson(x))),
        comments: List<Comment>.from(
            json["comments"].map((x) => Comment.fromJson(x))),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "post": post,
        "avatar": avatar,
        "content": content,
        "isBlocked": isBlocked,
        "postFormat": postFormat,
        "date": date.toIso8601String(),
        "likes": List<dynamic>.from(likes.map((x) => x.toJson())),
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
        "__v": v,
      };
}

class Comment {
  String user;
  String comment;
  String avatar;
  String id;
  DateTime date;

  Comment({
    required this.user,
    required this.comment,
    required this.avatar,
    required this.id,
    required this.date,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        user: json["user"],
        comment: json["comment"],
        avatar: json["avatar"],
        id: json["_id"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "comment": comment,
        "avatar": avatar,
        "_id": id,
        "date": date.toIso8601String(),
      };
}

class Like {
  String user;
  String id;

  Like({
    required this.user,
    required this.id,
  });

  factory Like.fromJson(Map<String, dynamic> json) => Like(
        user: json["user"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "_id": id,
      };
}
