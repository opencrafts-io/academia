import 'package:flutter/material.dart';

class Academia extends StatelessWidget {
  const Academia({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Academia",
      home: Scaffold(appBar: AppBar(title: Text("Academia"))),
    );
  }
}
