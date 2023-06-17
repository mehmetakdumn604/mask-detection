import 'package:flutter/material.dart';
import 'package:flutter_onboarding/core/constants/app_images.dart';
import 'package:flutter_onboarding/shared/widgets/localized_text.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tflite/tflite.dart';

import '../providers/tflite_controller.dart';

class MaskRecognitionPage extends StatefulWidget {
  const MaskRecognitionPage({Key? key}) : super(key: key);

  @override
  State<MaskRecognitionPage> createState() => _MaskRecognitionPageState();
}

class _MaskRecognitionPageState extends State<MaskRecognitionPage> {
  @override
  Widget build(BuildContext context) {
    final TfLiteController data = context.watch();
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
            const SizedBox(
              height: 50,
            ),
            Center(
              child: LocalizedText(
                "maskDetection",
                style: const TextStyle(color: Colors.purple, fontSize: 20),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: LocalizedText(
                'maskClassification',
                style: const TextStyle(color: Color(0xFFE99600), fontSize: 25, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: data.isLoading
                  ? SizedBox(
                      width: 300,
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: 300,
                            height: 250,
                            color: Colors.black,
                            // child: Image.asset(
                            //   "assets/flower.png",
                            //   fit: BoxFit.fill,
                            // ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: LocalizedText(
                              'pleaseSelectImage',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          )
                        ],
                      ))
                  : Column(
                      children: [
                        data.pickedImage == null ? AppImages.instance.maskPhotoWidget : SizedBox(height: 250, child: Image.file(data.pickedImage!)),
                      ],
                    ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => data.pickImage(ImageSource.camera),
                    child: Container(
                      width: MediaQuery.of(context).size.width - 250,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 17),
                      decoration: BoxDecoration(color: const Color(0xFFE99600), borderRadius: BorderRadius.circular(6)),
                      child: LocalizedText('camera', style: const TextStyle(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () => data.pickImage(ImageSource.gallery),
                    child: Container(
                      width: MediaQuery.of(context).size.width - 250,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 17),
                      decoration: BoxDecoration(color: const Color(0xFFE99600), borderRadius: BorderRadius.circular(6)),
                      child: LocalizedText('gallery', style: const TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            data.outputs.isEmpty
                ? LocalizedText(
                    'result',
                    style: const TextStyle(color: Colors.white),
                  )
                : Column(
                    children: [
                      Text(
                        "${data.outputs[0]['label'].substring(2)} : ${(data.outputs[0]['confidence'] * 100).toStringAsFixed(1)} %",
                        style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                      const SizedBox(height: 10),
                    ],
                  )
          ]),
        ),
      ),
    );
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }
}
