import 'package:flutter/material.dart';

class AppImages {
  static final AppImages _instance = AppImages._init();

  static AppImages get instance => _instance;
  AppImages._init();
  final String maskPhotoName = 'mask_image';

  AssetImage get maskPhoto => _ImageAssets(maskPhotoName);

  Image get maskPhotoWidget {
    return Image.asset(
      maskPhoto.assetName,
    );
  }
}

class _ImageAssets extends AssetImage {
  const _ImageAssets(String assetName) : super("assets/images/$assetName.jpeg");
}
