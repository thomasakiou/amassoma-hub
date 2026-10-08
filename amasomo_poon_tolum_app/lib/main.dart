import 'package:flutter/material.dart';
import 'app.dart';
import 'theme.dart';

void main() {
  runApp(const AmasomoApp());
}

class AmasomoApp extends StatelessWidget {
  const AmasomoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amasomo Pọọn Tolumọ',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(),
      home: const App(),
    );
  }
}
