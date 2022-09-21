import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/homePage.dart';
import 'preferences/shared_preference.dart';
import 'service/rest.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final pref = PreferenciasUsuario();
  await pref.initPrefs();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Service()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Rick & Morthy',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}
