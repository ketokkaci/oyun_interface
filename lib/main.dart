import 'package:flutter/material.dart';
import 'package:oyun_interface/pages/home_page.dart';
import 'package:yaz_client/yaz_client.dart';
import "/models/data_controller.dart";
void main() async {
  YazClient.init(
      secret1: "11111111111111111111111111111111",
      secret2: "11111111111111111111111111111111",
      host: '192.168.43.62',
      port: "9092");
  var connected = await socketService.connect();
  print(connected ? 'Giriş Yapıldı.' : 'Giriş Yapılamadı.');
  await DataController().init();
  var app = GameApp();

  runApp(app);
}

/// Her dart uygulaması main() fonksiyonu içinde çalışır ve biter
///
/// Her flutter uygulaması widget'tır
///
/// her uygulamanın ilk widget'ının build'i MaterialApp'tir
/// MaterialApp UUygulamadı her şeyi kapsar
/// uygulama, runApp(Widget örneği) fonksiyonu ile çalışır
///
/// Widget tanımlamanın iki yolu vardır:
/// stateless widget , stateful widget
/// bunlardan extends olan bir widget



/// Material App bizi bir sayfaya yönlendirmeli : (home veya başka)
/// Her sayfa bir widgettır



/// Durumsuz . Widget için yaratılan boşluk ile widget'ın farkı yok

class GameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
