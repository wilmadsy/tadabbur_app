class DzikirProgress {
  final int id;
  final int count;

  const DzikirProgress({
    required this.id,
    required this.count,
  });

  DzikirProgress copyWith({
    int? id,
    int? count,
  }) {
    return DzikirProgress(
      id: id ?? this.id,
      count: count ?? this.count,
    );
  }
}