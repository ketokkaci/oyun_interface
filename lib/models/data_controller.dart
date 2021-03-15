import 'package:yaz_client/yaz_client.dart';
import '/models/games.dart';
import '/models/publishers.dart';
import 'comment.dart';

///
enum SortType {
  ///
  establishDate,

  ///
  addDate,

  ///
  name,

  ///
  reviewCount
}

///
class DataController {
  DataController._();

  static final DataController _dataController = DataController._();

  ///
  factory DataController() => _dataController;

  ///
  SortType sortType = SortType.addDate;

  ///
  bool hasMore = true;

  ///
  bool isLoading = false;

  ///
  ///
  Sorting sorting = Sorting.descending;

  ///
  ///
  Map<String, Game> gameMap = {};

  ///
  ///
  List<String> gameList = [];

  ///
  Map<String, Publisher> publishersMap = {};

  ///
  Map<String, GameKind> gameKind = {};

  ///
  bool isInit = false;

  ///
  List<String> selectedKinds = [];

  /// selecteds'a eklenecek,
  /// sonra arama yapılacak

  ///
  Future<void> init() async {
    if (isInit) return;

    await Future.wait([_getKindsFromDb()]);

    isInit = true;
  }

  Future<void> _getKindsFromDb() async {
    var kindsData = await socketService.listQuery(Query.create('kinds'));

    var _k = kindsData!.map<GameKind>((e) => GameKind.fromJson(e));

    for (var kind in _k) {
      gameKind[kind.id] = kind;
    }

    print('sorgu yapıldı');
    return;
  }

  Future<void> _getGames(int offset) async {
    late String fieldName;
    if (sortType == SortType.establishDate) {
      fieldName = 'game_date';
    } else if (sortType == SortType.addDate) {
      fieldName = 'add_time';
    } else if (sortType == SortType.name) {
      fieldName = 'game_name';
    } else if (sortType == SortType.reviewCount) {
      fieldName = 'review_count';
    }

    /// Ve  =     alan : { "\$all" : [list]}
    /// Veya =    alan : [list]

    var _l = await socketService.listQuery(Query.create('games',
        equals: {"game_kinds": selectedKinds},
        limit: 5,
        sorts: {fieldName: sorting},
        offset: offset));
    for (var _gameMap in (_l)!) {
      var game = Game.fromJson(_gameMap);
      gameMap[game.id] = game;
      gameList.add(game.id);
    }
    hasMore = _l.length == 5;
    isLoading = false;
    return;
  }

  /// Listeyi baştan yükleme fonksyionu
  Future<void> getGamesFromDb() async {
    if (isLoading) return;
    isLoading = true;
    gameList.clear();
    hasMore = true;
    return _getGames(0);
  }

  ///
  Future<void> loadMore() async {
    if (isLoading) return;
    isLoading = true;
    if (hasMore) {
      return _getGames(gameList.length);
    }

    return;
  }

  ///
  Future<Publisher?> getPublisherFromDb(String publisherId) async {
    if (publishersMap[publisherId] != null) {
      return publishersMap[publisherId];
    }
    print("Veritabanından Getiriyor");
    var res = await socketService.query(
        Query.create('publishers', equals: {'publisher_id': publisherId}));
    var publisher = Publisher.fromMap(res.data!);
    publishersMap[publisher.id] = publisher;
    return publishersMap[publisherId];
  }

  ///
  Future<List<Comment>?> getCommentsByGameFromDb(String gameId) async {
    var _res = await socketService.listQuery(Query.create('comments',
        equals: {'game_id': gameId}, sorts: {"add_time": Sorting.descending}));
    return _res!.map((e) => Comment.fromMap(e)).toList();
  }

/* ///KindController giriş işlemlerini yaptı mı?
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
  }*/
}
