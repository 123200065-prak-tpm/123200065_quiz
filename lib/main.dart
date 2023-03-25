import 'package:flutter/material.dart';
import 'halaman_list_disease.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kuis-123200171',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HalamanList(),
    );
  }
}
