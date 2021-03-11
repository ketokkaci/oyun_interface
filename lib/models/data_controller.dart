import 'package:yaz_client/yaz_client.dart';
import '/models/games.dart';
import '/models/publishers.dart';

///
class DataController {
  DataController._();

  static final DataController _kindController = DataController._();

  ///
  factory DataController() => _kindController;

  ///KindController giriş işlemlerini yaptı mı?
  bool isInit = false;

  ///
  Future<void> init() async {
    if (isInit) return;

    await Future.wait(
        [_getKindsFromDb(), _getGamesFromDb(), _getPublisherFromDb()]);

    isInit = true;
  }

  /// tüm kindları barındıran liste.
  late List<GameKind> gameKind;
  late List<Game> games;
  late List<Publisher> publishers;

  /// veri tabanından kinds getiren fonk.
  Future<void> _getKindsFromDb() async {
    var kindsData = await socketService.listQuery(Query.create('kinds'));

    gameKind = kindsData.map<GameKind>((e) => GameKind.fromJson(e!)).toList();

    print('sorgu yapıldı');
    return;
  }

  /// veri tabanından games getiren fonk.
  Future<void> _getGamesFromDb() async {
    var kindsData = await socketService.listQuery(Query.create('games'));

    games = kindsData.map<Game>((e) => Game.fromJson(e!)).toList();

    print('sorgu yapıldı');
    return;
  }
/// veri tabanından publishers getiren fonk.
  Future<void> _getPublisherFromDb() async {
    var kindsData = await socketService.listQuery(Query.create('publishers'));

    publishers =
        kindsData.map<Publisher>((e) => Publisher.fromMap(e!)).toList();

    print('sorgu yapıldı');
    return;
  }
  }
