import 'dart:io';

// import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_v2/tflite_v2.dart';

class PlantLeafImagePicker extends StatefulWidget {
  const PlantLeafImagePicker({super.key});

  @override
  State<PlantLeafImagePicker> createState() => _PlantLeafImagePickerState();
}

class _PlantLeafImagePickerState extends State<PlantLeafImagePicker> {
  final ImagePicker picker = ImagePicker();
  File? _image;
  List? _output;

  @override
  void initState() {
    super.initState();
    loadModel().then((value) {
      print("Model Loaded!!! ✅✅✅");
      setState(() {});
    });
  }

  loadModel() async {
    await Tflite.loadModel(
        model: "assets/model/model_unquant.tflite",
        labels: "assets/model/labels.txt",
        numThreads: 1);
  }

  classifyImage(File image) async {
    try {
      print(image.path);

      var output = await Tflite.runModelOnImage(
        imageMean: 0.0,
        imageStd: 255.0,
        numResults: 2,
        threshold: 0.2,
        asynch: true,
        path: image.path,
      );

      if (output != null) {
        print(output);
        setState(() {
          _output = output;
        });

        // SnackBar(content: Text(output[0].label));
      }
    } catch (e) {
      print("Some error occured ❌❌❌");
      print(e);
    }
  }

  disposeModel() {
    Tflite.close();
  }

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
        child: SingleChildScrollView(
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
                  ? ElevatedButton(
                      onPressed: () async {
                        print("Detect image called 🚀🚀");
                        await classifyImage(_image!);
                        print("Done calling 🙃🙃🙃");
                      },
                      child: const Text("Detect"))
                  : const Text(""),
              _output == null ? Text('') : Text('${_output![0]['label']}')
            ],
          ),
        ),
      ),
    );
  }
}
