import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:sense_battle/models/model_noun.dart';
import 'package:sense_battle/models/model_noun_list.dart';

class MakeSentenceModel {
  int id;
  int round;
  DateTime startDate;
  DateTime endDate;
  NounListModel writing_collectors;
  MakeSentenceModel({
    required this.id,
    required this.round,
    required this.startDate,
    required this.endDate,
    required this.writing_collectors,
  });

  MakeSentenceModel copyWith({
    int? id,
    int? round,
    DateTime? startDate,
    DateTime? endDate,
    NounListModel? writing_collectors,
  }) {
    return MakeSentenceModel(
      id: id ?? this.id,
      round: round ?? this.round,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      writing_collectors: writing_collectors ?? this.writing_collectors,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'round': round,
      'startDate': startDate.millisecondsSinceEpoch,
      'endDate': endDate.millisecondsSinceEpoch,
      'writing_collectors': writing_collectors.toMap(),
    };
  }

  factory MakeSentenceModel.fromMap(Map<String, dynamic> map) {
    return MakeSentenceModel(
      id: map['id'],
      round: map['round'],
      startDate: DateTime.parse(map['startDate']),
      endDate: DateTime.parse(map['endDate']),
      writing_collectors: NounListModel.fromMap(map['writing_collectors'][0]),
    );
  }

  String toJson() => json.encode(toMap());

  factory MakeSentenceModel.fromJson(String source) => MakeSentenceModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MakeSentenceModel(id: $id, round: $round, startDate: $startDate, endDate: $endDate, writing_collectors: $writing_collectors)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MakeSentenceModel &&
        other.id == id &&
        other.round == round &&
        other.startDate == startDate &&
        other.endDate == endDate &&
        other.writing_collectors == writing_collectors;
  }

  @override
  int get hashCode {
    return id.hashCode ^ round.hashCode ^ startDate.hashCode ^ endDate.hashCode ^ writing_collectors.hashCode;
  }
}
