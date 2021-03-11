// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'games.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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

