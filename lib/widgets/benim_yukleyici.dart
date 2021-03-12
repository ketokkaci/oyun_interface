import 'package:flutter/material.dart';

class BenimYukleyici extends StatefulWidget {
  BenimYukleyici({Key? key}) : super(key: key);

  @override
  _BenimYukleyiciState createState() => _BenimYukleyiciState();
}

class _BenimYukleyiciState extends State<BenimYukleyici> {
  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      backgroundColor: Colors.red,
    );
  }
}
