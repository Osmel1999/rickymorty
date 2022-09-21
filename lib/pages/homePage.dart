import 'package:flutter/material.dart';
import 'package:interviewapp/preferences/shared_preference.dart';
import 'package:provider/provider.dart';

import '../service/rest.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

int index = 0;
List<String> db_option = ["character", "location", "episode"];

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final service = Provider.of<Service>(context);
    final pref = PreferenciasUsuario();

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Rick & Morthy")),
      ),
      body: (service.respMap.isEmpty)
          ? Center(
              child:
                  Text((service.error.isEmpty) ? "cargando..." : service.error),
            )
          : GridView.builder(
              itemCount: service.respMap.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 5.0,
              ),
              shrinkWrap: true,
              itemBuilder: (context, i) {
                return InkWell(
                  child: Card(
                      child: Stack(
                    children: [
                      (index == 0)
                          ? Image.network("${service.respMap[i]["image"]}")
                          : Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(service.respMap[i]["name"]),
                                  Text(service.respMap[i]
                                      [(index == 1) ? "type" : "episode"]),
                                ],
                              ),
                            ),
                      (pref.favorites.contains("${service.respMap[i]["name"]}"))
                          ? const Icon(Icons.favorite_rounded,
                              size: 34, color: Colors.red)
                          : const Icon(Icons.favorite_border_rounded,
                              size: 34, color: Colors.black)
                    ],
                  )),
                  onTap: () {
                    List<String> temp = pref.favorites;
                    setState(() {
                      if (!pref.favorites
                          .contains("${service.respMap[i]["name"]}")) {
                        temp.add("${service.respMap[i]["name"]}");
                        pref.favorites = temp;
                      } else {
                        temp.remove("${service.respMap[i]["name"]}");
                        pref.favorites = temp;
                      }
                    });
                  },
                );
              }),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Characters',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.public_sharp),
            label: 'Locations',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.ondemand_video_rounded),
            label: 'Episodes',
          ),
        ],
        currentIndex: index,
        onTap: (int i) async {
          index = i;
          service.db_selected = db_option[i];
          await service.initConfig();
          setState(() {});
        },
      ),
    );
  }
}
