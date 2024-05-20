import 'package:flutter/material.dart';
import 'image_upload.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Image Upload',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ImageUpload(),
    );
  }
}
