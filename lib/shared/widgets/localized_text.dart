import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

// Text widget for localizing text
class LocalizedText extends Text {
  LocalizedText(
    String txt, {
    Key? key,
    TextStyle? style,
    TextAlign? textAlign,
  }) : super(
          txt.tr(),
          key: key,
          style: style ?? const TextStyle(color: Colors.black, fontSize: 18),
          textAlign: textAlign,
        );
}
