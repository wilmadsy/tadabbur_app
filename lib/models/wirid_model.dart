class WiridModel {
  final String title;
  final String arabic;
  final String latin;
  final String meaning;

  const WiridModel({
    required this.title,
    required this.arabic,
    this.latin = '',
    this.meaning = '',
  });
}