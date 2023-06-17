import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding/providers/tflite_controller.dart';
import 'package:flutter_onboarding/screens/mask_recognition.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

import 'core/constants/app_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await TfLiteController.tfInit();
  runApp(EasyLocalization(
    supportedLocales: AppConstants.instance.supportedLanguages,
    path: AppConstants.instance.localizationPath,
    fallbackLocale: AppConstants.instance.supportedLanguages.first,
    useOnlyLangCode: true,
    useFallbackTranslations: true,
    child: MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => TfLiteController.instance)],
      child: const MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TfLiteController controller = context.watch();
    return MaterialApp(
      title: AppConstants.instance.appName,
      home: const MaskRecognitionPage(),
      locale: context.locale,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return LoadingOverlay(isLoading: controller.isLoading, child: child ?? const SizedBox());
      },
    );
  }
}
