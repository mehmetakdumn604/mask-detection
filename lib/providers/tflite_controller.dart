import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tflite/tflite.dart';

class TfLiteController extends ChangeNotifier {
  static final TfLiteController _instance = TfLiteController._internal();
  static TfLiteController get instance => _instance;

  final String _labelPath = "assets/labels.txt";
  final String _modelPath = "assets/model_unquant.tflite";
  TfLiteController._internal();

  File? _pickedImage;

  File? get pickedImage => _pickedImage;

  set pickedImage(File? value) {
    _pickedImage = value;
    notifyListeners();
  }

  static tfInit() async {
    await loadModel();
  }

  get providers => [ChangeNotifierProvider(create: (context) => TfLiteController.instance)];

  static Future<void> loadModel() async {
    try {
      await Tflite.loadModel(
        model: instance._modelPath,
        labels: instance._labelPath,
      );
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<void> onClose() async {
    try {
      await Tflite.close();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> pickImage(ImageSource imageSource) async {
    try {
      final PickedFile? image = await ImagePicker.platform.pickImage(source: imageSource);
      if (image == null) return;
      changeLoading();
      final File file = File(image.path);
      pickedImage = file;
      await classifyImage(file);
    } catch (e) {
      log(e.toString());
    }
  }

  classifyImage(File file) async {
    var output = await Tflite.runModelOnImage(
      path: file.path,
      numResults: 2,
      threshold: .5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    log(output.toString());

    if (output == null) return;
    outputs = output;
    changeLoading();
    notifyListeners();
  }

  List<dynamic> outputs = [];
  bool isLoading = false;

  void changeLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }
}
