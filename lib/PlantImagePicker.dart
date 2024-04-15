import 'dart:io';

// import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PlantLeafImagePicker extends StatefulWidget {
  const PlantLeafImagePicker({super.key});

  @override
  State<PlantLeafImagePicker> createState() => _PlantLeafImagePickerState();
}

class _PlantLeafImagePickerState extends State<PlantLeafImagePicker> {
  final ImagePicker picker = ImagePicker();
  File? _image;

  void getImageFromGallary() async {
    var result = await picker.pickImage(source: ImageSource.gallery);
    if (result != null) {
      setState(() {
        _image = File(result.path);
      });
    }
  }

  void getImageFromCamera() async {
    var result = await picker.pickImage(source: ImageSource.camera);
    if (result != null) {
      setState(() {
        _image = File(result.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Planty"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Please choose image from your gallary or click a new image to procced futher",
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    getImageFromGallary();
                  },
                  child: const Text("Gallary"),
                ),
                const SizedBox(
                  width: 16,
                ),
                ElevatedButton(
                  onPressed: () {
                    getImageFromCamera();
                  },
                  child: const Text("Camera"),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            _image != null ? const Text("Selected Files") : const Text(""),
            const SizedBox(
              height: 16,
            ),
            ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  if (_image != null) {
                    File file = File(_image!.path);
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
                itemCount: _image == null ? 0 : 1),
            const SizedBox(
              height: 16,
            ),
            _image != null
                ? ElevatedButton(onPressed: () {}, child: const Text("Detect"))
                : const Text("")
          ],
        ),
      ),
    );
  }
}
