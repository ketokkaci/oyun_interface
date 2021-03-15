import 'package:json_annotation/json_annotation.dart';
import 'package:yaz_client/yaz_client.dart';

import 'comment.dart';

///
class GameKind {
  @JsonKey(name: "kind_name")

  ///
  String name;

  ///
  @JsonKey(name: "popularity_point")
  double point;

  ///
  @JsonKey(name: "kind_id")
  String id;

  ///
  GameKind({required this.name, required this.point, required this.id});

  ///
  factory GameKind.fromJson(Map<String, dynamic> map) =>
      _$GameKindFromJson(map);

  ///
  GameKind.create(this.name)
      : id = Statics.getRandomId(20),
        point = 0;
}

@JsonSerializable()
///
class Game {
  ///return DateTime from json stored type time (millisecondsSinceEpoch)
  static DateTime dateFromJson(int raw) =>
      DateTime.fromMillisecondsSinceEpoch(raw);

  /// return json stored type time (millisecondsSinceEpoch) from DateTime
  static int dateToInt(DateTime time) => time.millisecondsSinceEpoch;

  @JsonKey(name: "game_id")

  ///
  String id;

  ///
  @JsonKey(name: "game_name")
  String name;

  ///
  @JsonKey(name: "publisher_id")
  String publisherId;

  ///
  @JsonKey(name: "game_date")
  int date;

  ///
  @JsonKey(name: "game_kinds")
  List<String> kinds;

  ///
  @JsonKey(name: "add_time", toJson: dateToInt, fromJson: dateFromJson)
  DateTime addTime;

  ///
  @JsonKey(name: "game_point")
  double point;

  ///
  @JsonKey(name: "review_count")
  int reviewCount;

  ///
  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);

  ///
  Game(
      {required this.name,
      required this.point,
      required this.id,
      required this.date,
      required this.addTime,
      required this.reviewCount,
      required this.kinds,
      required this.publisherId});

  ///oyuna yorum ekleyen fonk.
  ///başarısızsa null döndürür
  Future<Comment?> addComment(
      {required int commentPoint,
      required String content,
      required String userName}) async {
    var _c = Comment.create(
        gameId: id,
        point: commentPoint,
        content: content,
        userName: userName);
    var _res = await socketService
        .insertQuery(Query.create("comments", document: _c.toMap()));
    if (_res.isSuccess) {
      return _c;
    }
    return null;
  }
}

GameKind _$GameKindFromJson(Map<String, dynamic> json) {
  return GameKind(
    name: json['kind_name'] as String,
    point: (json['popularity_point'] as num).toDouble(),
    id: json['kind_id'] as String,
  );
}

Game _$GameFromJson(Map<String, dynamic> json) {
  return Game(
    name: json['game_name'] as String,
    point: (json['game_point'] as num).toDouble(),
    id: json['game_id'] as String,
    date: json['game_date'] as int,
    addTime: Game.dateFromJson(json['add_time'] as int),
    reviewCount: json['review_count'] as int,
    kinds:
        (json['game_kinds'] as List<dynamic>).map((e) => e.toString()).toList(),
    publisherId: json['publisher_id'] as String,
  );
}
