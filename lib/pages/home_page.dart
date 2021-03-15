import 'package:flutter/material.dart';
import 'package:yaz_client/yaz_client.dart';

import '../models/data_controller.dart';
import '../widgets/benim_yukleyici.dart';
import '../widgets/game_widget.dart';

/// Her safyayı kapsayan bir tane Scaffold Widget'ı olmalıdır
/// Bu Widget Classı - Bu widget için yaratılan boşluğu
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

/// Bu Widget'ın durumu - on anki
///
///

/// Oyun listemiz çekilecek
/// İlk oyunlar yüklenecek

class _HomePageState extends State<HomePage> {
  DataController dataController = DataController();

  @override
  void initState() {
    dataController.getGamesFromDb().then((value) async {
      await Future.delayed(Duration(milliseconds: 100));
      setState(() {});
    });
    super.initState();
  }

  /// Eğer listemizde eleman yoksa aşağıda yükleniyor animasyonu olsun
  ///

  @override
  Widget build(BuildContext context) {
    /// Column tüm childrenları build eder
    /// ListView kaydırmaya göre gerekirse build eder
    /// Gerektiğinde widget'ın bilgisini itemBuilder'ı çalıştırarak alır
    return Scaffold(
        body: Column(
      children: [
        Row(
          children: [
            IconButton(
                onPressed: () {
                  setState(() {});
                },
                icon: Icon(Icons.ac_unit)),
            IconButton(
                onPressed: () async {
                  /// List<SortType> => List<...>

                  var l = await showDialog<List>(
                      context: context,
                      builder: (c) {
                        return SimpleDialog(
                          children: SortType.values
                              .map<Widget>((e) => SimpleDialogOption(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              Navigator.pop(
                                                  c, [e, Sorting.ascending]);
                                            },
                                            icon: Icon(Icons.arrow_upward)),
                                        Text(e.toString().split(".").last),
                                        IconButton(
                                            onPressed: () {
                                              Navigator.pop(
                                                  c, [e, Sorting.descending]);
                                            },
                                            icon: Icon(Icons.arrow_downward)),
                                      ],
                                    ),
                                  ))
                              .toList(),
                        );
                      });

                  if (l != null && l.isNotEmpty) {
                    dataController.sortType = l[0];
                    dataController.sorting = l[1];
                    await dataController.getGamesFromDb();
                    setState(() {});
                  }
                },
                icon: Icon(Icons.sort)),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: dataController.gameKind.entries
                .map((e) => ActionChip(
                    backgroundColor:
                        dataController.selectedKinds.contains(e.key)
                            ? Colors.blue
                            : null,
                    label: Text(
                      e.value.name,
                      style: TextStyle(
                          color: dataController.selectedKinds.contains(e.key)
                              ? Colors.white
                              : null),
                    ),
                    onPressed: () async {
                      if (dataController.selectedKinds.contains(e.key)) {
                        /// Seçiliyken basmış
                        dataController.selectedKinds.remove(e.key);

                        setState(() {});

                        await dataController.getGamesFromDb();

                        setState(() {});
                      } else {
                        /// Seçili Değilken basmış
                        dataController.selectedKinds.add(e.key);

                        setState(() {});

                        await dataController.getGamesFromDb();

                        setState(() {});
                      }
                    }))
                .toList(),
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              await dataController.getGamesFromDb();
              return;
            },
            child: ListView.builder(
                itemCount: dataController.gameList.length + 1,
                itemBuilder: (con, index) {
                  print(index);

                  if (index == dataController.gameList.length) {
                    if (!dataController.hasMore) {
                      return Text("Daha fazla oyun yok");
                    }
                    return Container();
                  }
                  var game =
                      dataController.gameMap[dataController.gameList[index]];

                  /// index : kaçıncı widget'ı oluşturduğunun bilgisi
                  if (index == dataController.gameList.length - 1) {
                    if (dataController.hasMore) {
                      dataController.loadMore().then((value) {
                        setState(() {});
                      });
                    }
                  }

                  return GameWidget(game!);
                }),
          ),
        ),
        if (dataController.gameList.isEmpty ||
            (dataController.isLoading && dataController.hasMore))
          BenimYukleyici(),

        // if (dataController.gameList.isNotEmpty)
        //   GameWidget(dataController.gameMap[dataController.gameList.first]!)
      ],
    ));
  }
}
