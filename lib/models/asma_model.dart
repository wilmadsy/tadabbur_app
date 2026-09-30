class AsmaModel {
  final int id;
  final String arabic;
  final String latin;
  final String meaning;
  final int count;
  final int progress;
  final bool favorite;

  const AsmaModel({
    required this.id,
    required this.arabic,
    required this.latin,
    required this.meaning,
    this.count = 0,
    this.progress = 0,
    this.favorite = false,
  });

  factory AsmaModel.fromMap(Map<String, dynamic> map) {
    return AsmaModel(
      id: map['id'] as int,
      arabic: map['arabic'] as String,
      latin: map['latin'] as String,
      meaning: map['meaning'] as String,
      count: map['count'] as int,
      progress: map['progress'] as int,
      favorite: map['favorite'] == 1,
    );
  }
}
