import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quzi/fist.dart';
import 'package:quzi/quzi.dart';
import 'package:quzi/model/model.dart';
import 'package:quzi/result.dart';

//./gradlew signingReport
// flutter build apk --split-per-abi

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Model(),
      child: MaterialApp(
        onGenerateRoute: (settings) {
          Widget Function(BuildContext) builder = (c) => const QuziPage();
          if (settings.name == '/') {
            builder = (c) => const First();
          }
          if (settings.name == Result.id) {
            builder = (c) => const Result();
          }
          if (settings.name == QuziPage.id) {
            builder = (c) => const QuziPage();
          }

          return MaterialPageRoute(settings: settings, builder: builder);
        },
        title: 'Fast Beer',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
