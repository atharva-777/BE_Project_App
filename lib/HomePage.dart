import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Planty"),
      ),
      body: Column(
        children: [
          const Text("Welcome to Planty! Plant Leaf Disease Detection"),
          const Text(
              "App for detecting the plant diseases by inputing the images of leaf and then processing it with deep learning model for detecting whether that is infected or not"),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/detect");
              },
              child: const Text("Get Started"))
        ],
      ),
    );
  }
}
