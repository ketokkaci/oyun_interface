import 'package:flutter/material.dart';
import 'main.dart';

///
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (c) {
                  //   return AddGames();
                 // }));
                },
                child: Text("Oyun Ekle")),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (c) {
                    return MyHomePage(title: "",);
                  }));
                },
                child: Text("Yayıncı Ekle")),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {

                  // Navigator.push(context, MaterialPageRoute(builder: (c) {
                  //   return AddKindsPage();
                  // }));
                },
                child: Text("Tür Ekle")),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
