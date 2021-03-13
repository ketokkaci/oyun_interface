class GameKind {
  String name;

  double point;

  String id;

  ///
  GameKind({required this.name, required this.point, required this.id});

  ///
  factory GameKind.fromJson(Map<String, dynamic> map) =>
      _$GameKindFromJson(map);
}

GameKind _$GameKindFromJson(Map<String, dynamic> json) {
  return GameKind(
    name: json['kind_name'] as String,
    point: (json['popularity_point'] as num).toDouble(),
    id: json['kind_id'] as String,
  );
}

Map<String, dynamic> _$GameKindToJson(GameKind instance) => <String, dynamic>{
      'kind_name': instance.name,
      'popularity_point': instance.point,
      'kind_id': instance.id,
    };
