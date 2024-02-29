import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class PlantLeafImagePicker extends StatefulWidget {
  const PlantLeafImagePicker({super.key});

  @override
  State<PlantLeafImagePicker> createState() => _PlantLeafImagePickerState();
}

class _PlantLeafImagePickerState extends State<PlantLeafImagePicker> {
  FilePickerResult? result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Planty"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () async {
                  result = await FilePicker.platform.pickFiles();

                  if (result == null) {
                    print("No files were picked");
                    return;
                  } else {
                    setState(() {});
                    for (var file in result!.files) {
                      print(file.name);
                    }
                  }
                },
                child: const Text("Choose image")),
            const SizedBox(
              height: 24,
            ),
            const Text("Selected Files"),
            const SizedBox(
              height: 16,
            ),
            ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  if (result != null) {
                    File file = File(result!.files.single.path!);
                    return Image.file(
                      file,
                      width: double.infinity,
                      height: 400,
                    );
                  }

                  return const Text("no file selected");
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 12,
                  );
                },
                itemCount: result == null ? 0 : result!.files.length)
          ],
        ),
      ),
    );
  }
}
