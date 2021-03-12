import 'package:flutter/material.dart';
import 'package:oyun_interface/models/games.dart';

/// Widget'ın içindeki her şey final olmalıdır
class GameWidget extends StatefulWidget {
  ///
  GameWidget(this.game);

  ///
  final Game game;

  /// Game Widget 'ı oluşturmak için Game tipinden bir nesneye ihtiyacım var

  @override
  _GameWidgetState createState() => _GameWidgetState();
}

class _GameWidgetState extends State<GameWidget> {
  @override
  Widget build(BuildContext context) {

    return Container(
        margin: EdgeInsets.all(10),
        height: 250,
        color: Colors.blue,
        child: Column(
          children: [
            Text("${widget.game.name}"),
            Text("${widget.game.date} Yılında Çıktı")
          ],
        ));
  }
}
