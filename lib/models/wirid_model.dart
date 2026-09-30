class WiridModel {
  final int? id;
  final String title;
  final String arabic;
  final String latin;
  final String meaning;

  const WiridModel({
    this.id,
    required this.title,
    required this.arabic,
    this.latin = '',
    this.meaning = '',
  });

  factory WiridModel.fromMap(Map<String, dynamic> map) {
    return WiridModel(
      id: map['id'] as int,
      title: map['title'] as String,
      arabic: map['arabic'] as String,
      latin: map['latin'] as String? ?? '',
      meaning: map['meaning'] as String? ?? '',
    );
  }
}