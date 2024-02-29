import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Planty"),
      ),
      body: const Column(
        children: [
          Text("Welcome to Planty! Plant Leaf Disease Detection"),
          Text(
              "App for detecting the plant diseases by inputing the images of leaf and then processing it with deep learning model for detecting whether that is infected or not")
        ],
      ),
    );
  }
}
