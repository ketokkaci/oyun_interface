import 'package:flutter/material.dart';
import 'package:yaz_client/yaz_client.dart';

import '../models/games.dart';
import '../models/publishers.dart';
import '../widgets/game_widget.dart';

///
class PublisherPage extends StatefulWidget {
  ///
  PublisherPage({required this.publisher});

  ///
  final Publisher publisher;

  @override
  _PublisherPageState createState() => _PublisherPageState();
}

class _PublisherPageState extends State<PublisherPage> {
  List<Game>? games;

  Future<void> getGamesByPublisherFromDb() async {
    var _l = await socketService.listQuery(
        Query.create('games', equals: {'publisher_id': widget.publisher.id}));
    setState(() {
      games = _l!.map((e) => Game.fromJson(e)).toList();
    });
  }

  void initState() {
    getGamesByPublisherFromDb();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: games == null
          ? CircularProgressIndicator()
          : ListView.builder(itemCount:games!.length,
              itemBuilder: (context, index) {
                return GameWidget(games![index]);
              },
            ),
      appBar: AppBar(
        title: Text(widget.publisher.name),
      ),
    );
  }
}
