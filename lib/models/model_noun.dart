import 'dart:convert';

class MounModel {
  int id;
  String word;
  String? wordDesc;
  String? sourceUrl;
  MounModel({
    required this.id,
    required this.word,
    this.wordDesc,
    this.sourceUrl,
  });

  MounModel copyWith({
    int? id,
    String? word,
    String? wordDesc,
    String? sourceUrl,
  }) {
    return MounModel(
      id: id ?? this.id,
      word: word ?? this.word,
      wordDesc: wordDesc ?? this.wordDesc,
      sourceUrl: sourceUrl ?? this.sourceUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'word': word,
      'wordDesc': wordDesc,
      'sourceUrl': sourceUrl,
    };
  }

  factory MounModel.fromMap(Map<String, dynamic> map) {
    return MounModel(
      id: map['id'],
      word: map['word'],
      wordDesc: map['wordDesc'],
      sourceUrl: map['sourceUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MounModel.fromJson(String source) => MounModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MounModel(id: $id, word: $word, wordDesc: $wordDesc, sourceUrl: $sourceUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MounModel && other.id == id && other.word == word && other.wordDesc == wordDesc && other.sourceUrl == sourceUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^ word.hashCode ^ wordDesc.hashCode ^ sourceUrl.hashCode;
  }
}
