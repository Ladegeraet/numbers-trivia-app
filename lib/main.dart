import 'package:flutter/material.dart';
import 'package:numbers_trivia_app/features/number_trivia/presentation/pages/number_trivia_page.dart';

import 'injection_container.dart' as getIt;

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await getIt.setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Trivia App',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        accentColor: Colors.orange,
      ),
      home: NumberTriviaPage(),
    );
  }
}
