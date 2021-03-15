import 'package:flutter/material.dart';
import 'package:oyun_interface/models/comment.dart';
import 'package:oyun_interface/pages/publisher_page.dart';
import 'package:yaz_client/yaz_client.dart';
import '../models/data_controller.dart';
import '../models/games.dart';
import '../models/publishers.dart';

class GamePage extends StatefulWidget {
  GamePage({required this.game, Key? key}) : super(key: key);
  final Game game;

  /// Burada her şey sabit
  /// immutable

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  /// Buraya Publisher? getir
  /// Ne zaman? Sayfa açıldığında getirmeye başlasın
  /// geldiğinde scaffold ın bodysine
  /// ismini yazdır. Gelmeden önce animasyon döndür
  Publisher? publisher;
  List<Comment> comments = [];
  late SocketDataListener listener;

  Future<void> _get() async {
    publisher =
        await DataController().getPublisherFromDb(widget.game.publisherId);
    comments =
        (await DataController().getCommentsByGameFromDb(widget.game.id)) ?? [];
    setState(() {});

    return;
  }

  void _listen() {
    listener = socketService.listenDocument(
        Query.create("games", equals: {"game_id": widget.game.id}));
    listener.listen((event) {
      var _g = Game.fromJson(event.data!);
      dataController.gameMap[_g.id] = _g;

      setState(() {
        game = dataController.gameMap[_g.id]!;
      });
    });
  }

  late Game game;

  @override
  void initState() {
    game = widget.game;
    _get();
    _listen();
    print(widget.game.kinds.map((e) => dataController.gameKind[e]!.name));
    super.initState();
  }

  DataController dataController = DataController();

  @override
  void dispose() {
    listener.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          game.addComment(
              commentPoint: 150, content: "güzel oyun", userName: "kemal");
        },
      ),
      appBar: AppBar(
          title: Text(
        "${game.name}",
      )),
      body: publisher != null
          ? Center(
              child: Column(
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (contex) {
                          return PublisherPage(
                            publisher: publisher!,
                          );
                        }));
                      },
                      child:
                          Text("${publisher!.name}     ${game.reviewCount}")),
                  for (var com in comments) Text(com.content)

                ],
              ),
            )
          : CircularProgressIndicator(),
    );
  }
}
