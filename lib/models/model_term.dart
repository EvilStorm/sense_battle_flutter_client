import 'dart:convert';

class TermModel {
  int? id;
  String? term;
  String? userTerm;
  TermModel({
    this.id,
    this.term,
    this.userTerm,
  });

  TermModel copyWith({
    int? id,
    String? term,
    String? userTerm,
  }) {
    return TermModel(
      id: id ?? this.id,
      term: term ?? this.term,
      userTerm: userTerm ?? this.userTerm,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'term': term,
      'userTerm': userTerm,
    };
  }

  factory TermModel.fromMap(Map<String, dynamic> map) {
    return TermModel(
      id: map['id'],
      term: map['term'],
      userTerm: map['userTerm'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TermModel.fromJson(String source) => TermModel.fromMap(json.decode(source));

  @override
  String toString() => 'TermModel(id: $id, term: $term, userTerm: $userTerm)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TermModel && other.id == id && other.term == term && other.userTerm == userTerm;
  }

  @override
  int get hashCode => id.hashCode ^ term.hashCode ^ userTerm.hashCode;
}
