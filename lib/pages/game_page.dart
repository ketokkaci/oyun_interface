import 'package:flutter/material.dart';
import 'package:yaz_client/yaz_client.dart';

import '../models/comment.dart';
import '../models/data_controller.dart';
import '../models/games.dart';
import '../models/publishers.dart';
import 'publisher_page.dart';

/// Oyun sayfası
class GamePage extends StatefulWidget {
  /// Oyun sayfası construct etmek için bir game gerekli
  GamePage({required this.game, Key? key}) : super(key: key);

  ///
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
  TextEditingController nameController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  Future<void> _get() async {
    publisher =
        await DataController().getPublisherFromDb(widget.game.publisherId);
    comments =
        (await DataController().getCommentsByGameFromDb(widget.game.id)) ?? [];
    time(game.addTime);
    setState(() {});

    return;
  }

  String time(DateTime addTime) {
    var beforeAdd = (DateTime.now().millisecondsSinceEpoch) -
        (addTime.millisecondsSinceEpoch);
    var duration = Duration(milliseconds: beforeAdd);
    if (duration.inSeconds <= 60) {
      return 'Az önce ';
    } else if (duration.inMinutes <= 60) {
      return "${duration.inMinutes} dak. önce";
    } else if (duration.inHours <= 24) {
      return "${duration.inHours} saat önce";
    } else if (duration.inDays <= 365) {
      return "${duration.inDays} gün önce";
    }
    return "yıllaaar önce";
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
        onPressed: () async {},
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
                      child: Text("${publisher!.name}"
                          "   ${game.reviewCount}"
                          " inceleme yazıldı")),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: "isminiz",
                    ),
                  ),
                  TextField(
                    controller: contentController,
                    decoration: InputDecoration(
                        hintText: "yorumunuz",
                        suffixIcon: IconButton(
                          onPressed: () async {
                            /// name ve content'in boş text olmadığından emin ol
                            if (nameController.text.isNotEmpty &&
                                contentController.text.isNotEmpty) {
                              var exists = await socketService.exists(
                                  Query.create('comments', equals: {
                                "user_name": nameController.text
                              }));

                              if (exists ?? false) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                        Text("Bu isimle zaten"
                                            " inceleme yapıldı!")));
                              } else {
                                /// Yoksa
                                var _c = await game.addComment(
                                    commentPoint: 150,
                                    content: contentController.text,
                                    userName: nameController.text);
                                if (_c != null) {
                                  comments.insert(0, _c);
                                  contentController.clear();
                                  nameController.clear();
                                  setState(() {});
                                }
                              }
                            }
                          },
                          icon: Icon(Icons.send),
                        )),
                  ),
                  for (var com in comments)
                    Text("${com.userName}    "
                        "${com.content}"
                        "    ${time(com.addTime)} "),
                ],
              ),
            )
          : CircularProgressIndicator(),
    );
  }
}
