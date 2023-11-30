import 'package:get/get.dart';
import 'package:getx_todo_app/i18n/english.dart';
import 'package:getx_todo_app/i18n/indonesian.dart';

class LocalizationTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': englishTranslations,
        'id_ID': indonesianTranslations,
      };
}
