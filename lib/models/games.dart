import 'package:json_annotation/json_annotation.dart';
import 'package:yaz_client/yaz_client.dart';

part '/models/games_g.dart';

@JsonSerializable()
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
  /// return DateTime from json stored type time (millisecondsSinceEpoch)
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

}
