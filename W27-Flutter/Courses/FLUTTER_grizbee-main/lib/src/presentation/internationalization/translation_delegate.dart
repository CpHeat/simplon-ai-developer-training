import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:grizbee/src/presentation/internationalization/translation.dart';

class TranslationDelegate extends LocalizationsDelegate<Translation> {
  TranslationDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'fr'].contains(locale.languageCode);

  @override
  Future<Translation> load(Locale locale) => SynchronousFuture<Translation>(Translation(locale));

  @override
  bool shouldReload(TranslationDelegate old) => false;
}
