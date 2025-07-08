// ignore_for_file: non_constant_identifier_names, constant_identifier_names

enum Language {
  BAHASA("id"),
  ENGLISH("en");

  final String locale;

  const Language(this.locale);

  static Language valueOf(String locale) {
    return (Language.values.where((element) => element.locale == locale).firstOrNull) ?? Language.BAHASA;
  }
}
