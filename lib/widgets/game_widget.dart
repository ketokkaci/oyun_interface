import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oyun_interface/models/games.dart';
import 'package:oyun_interface/pages/game_page.dart';

class Daire<T> {
  Daire({required this.orjin, required this.radius});

  T orjin;

  double radius;

  T getir() {
    return orjin;
  }
}

class Cizgi {
  Cizgi(this.a);

  double a;
}

a() {
  var b = Nokta(8, 1);
  var ciz = Cizgi(8);
  var daire = Daire<Cizgi>(orjin: ciz, radius: 8.1);

  daire.getir();
}

/// X , Y , Noktayı oluşturmak için bu bilgilere ihtiyaç var
class Nokta {
  Nokta(this.x, this.y);

  double x, y;
}

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
