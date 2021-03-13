import 'package:flutter/material.dart';
import 'package:oyun_interface/models/data_controller.dart';
import 'package:oyun_interface/models/games.dart';
import 'package:oyun_interface/models/publishers.dart';
import 'package:oyun_interface/widgets/game_widget.dart';

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

  Future<void> _getPub() async {
    publisher =
        await DataController().getPublisherFromDb(widget.game.publisherId);

    setState(() {});
    return;
  }

  @override
  void initState() {
    _getPub();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "${widget.game.name}",
      )),
      body: publisher != null
          ? Center(
              child: Text("${publisher!.name} ${publisher!.country}"),
            )
          : CircularProgressIndicator(),
    );
  }
}
