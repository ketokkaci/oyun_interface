import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/games.dart';
import '../pages/game_page.dart';


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
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (contex) {
          return GamePage(game: widget.game);
        }));
      },
      child: Container(
          margin: EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 10),
                child: Text(
                  "${widget.game.name}",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              )),
              Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 70,
                  ),
                  Text(
                    "${widget.game.point} ",
                    style: TextStyle(fontSize: 17),
                  )
                ],
              )
            ],
          )),
    );
  }
}
