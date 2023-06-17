import 'package:flutter/material.dart';

class AppConstants {
  static final AppConstants _instance = AppConstants._init();

  static AppConstants get instance => _instance;
  AppConstants._init();

  final String appName = "Mask Detection App";

  final List<Locale> supportedLanguages = const [Locale("en"), Locale("tr")];

  final String localizationPath = "assets/translations";
}
