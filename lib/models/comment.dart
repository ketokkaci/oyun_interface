import 'package:yaz_client/yaz_client.dart';

///
class Comment {
  ///
  String id,

      ///
      gameId,

      ///
      userName,

      ///
      content;

  ///
  DateTime addTime;

  ///
  int point;

  ///
  Comment(
      {required this.id,
      required this.gameId,
      required this.addTime,
      required this.point,
      required this.content,
      required this.userName});

  ///
  Comment.create(
      {required this.gameId,
      required this.point,
      required this.content,
      required this.userName})
      : id = Statics.getRandomId(30),
        addTime = DateTime.now();

  ///
  Map<String, dynamic> toMap() {
    return {
      "comment_id": id,
      "game_id": gameId,
      "point": point,
      "content": content,
      "user_name": userName,
      "add_time": addTime.millisecondsSinceEpoch
    };
  }

  ///
  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
        id: map["comment_id"],
        gameId: map["game_id"],
        addTime: DateTime.fromMillisecondsSinceEpoch(map["add_time"]),
        point: map["point"],
        content: map["content"],
        userName: map["user_name"]);
  }
}
