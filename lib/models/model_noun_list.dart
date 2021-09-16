import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:sense_battle/models/model_noun.dart';

class NounListModel {
  int id;
  List<MounModel> nouns;
  NounListModel({
    required this.id,
    required this.nouns,
  });

  NounListModel copyWith({
    int? id,
    List<MounModel>? nouns,
  }) {
    return NounListModel(
      id: id ?? this.id,
      nouns: nouns ?? this.nouns,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nouns': nouns.map((x) => x.toMap()).toList(),
    };
  }

  factory NounListModel.fromMap(Map<String, dynamic> map) {
    return NounListModel(
      id: map['id'],
      nouns: List<MounModel>.from(map['nouns']?.map((x) => MounModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory NounListModel.fromJson(String source) => NounListModel.fromMap(json.decode(source));

  @override
  String toString() => 'NounListModel(id: $id, nouns: $nouns)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NounListModel && other.id == id && listEquals(other.nouns, nouns);
  }

  @override
  int get hashCode => id.hashCode ^ nouns.hashCode;
}
