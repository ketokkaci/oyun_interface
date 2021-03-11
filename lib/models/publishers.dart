import 'package:yaz_client/yaz_client.dart';

///
class Publisher {
  ///
  String id;
  ///
  String name;
  ///
  String country;
  ///
  int establishDate;
  ///
  String webSite;
  ///
  int gameCount;
  ///
  DateTime _addTime;
  ///
  DateTime _lastUpdate;

  ///
  Publisher(
      {required this.id,
        required this.name,
        required this.country,
        required DateTime addTime,
        required DateTime lastUpdate,
        required this.establishDate,
        required this.gameCount,
        required this.webSite})
      : _addTime = addTime,
        _lastUpdate = lastUpdate;

  /// Contructors cant return value....
  /// Kurucular değer döndürmez abiiii
  ///

  factory Publisher.fromMap(Map<String, dynamic> map) {
    return Publisher(
        id: map["publisher_id"],
        addTime: DateTime.fromMillisecondsSinceEpoch(map["add_time"]),
        country: map["country"],
        establishDate: map["establish_date"],
        gameCount: map["game_count"],
        lastUpdate: DateTime.fromMillisecondsSinceEpoch(map["last_update"]),
        name: map["publisher_name"],
        webSite: map["publisher_web_site"]);
  }
  @override
  String toString() {
    return "Publisher: $name";
  }




}
