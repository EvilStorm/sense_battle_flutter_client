import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:sense_battle/models/model_app_start_notify.dart';
import 'package:sense_battle/models/model_app_version.dart';
import 'package:sense_battle/models/model_term.dart';

class AppStartMergedDataModel {

  AppStartNotifyModel? notifies;
  List<AppVersionModel>? appVer;
  TermModel? term;
  AppStartMergedDataModel({
    this.notifies,
    this.appVer,
    this.term,
  });

  

  AppStartMergedDataModel copyWith({
    AppStartNotifyModel? notifies,
    List<AppVersionModel>? appVer,
    TermModel? term,
  }) {
    return AppStartMergedDataModel(
      notifies: notifies ?? this.notifies,
      appVer: appVer ?? this.appVer,
      term: term ?? this.term,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'notifies': notifies?.toMap(),
      'appVer': appVer?.map((x) => x.toMap()).toList(),
      'term': term?.toMap(),
    };
  }

  factory AppStartMergedDataModel.fromMap(Map<String, dynamic> map) {
    return AppStartMergedDataModel(
      notifies: AppStartNotifyModel.fromMap(map['notifies']),
      appVer: List<AppVersionModel>.from(map['appVer']?.map((x) => AppVersionModel.fromMap(x))),
      term: (map['term'] != null) ?TermModel.fromMap(map['term']) :null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppStartMergedDataModel.fromJson(String source) => AppStartMergedDataModel.fromMap(json.decode(source));

  @override
  String toString() => 'AppStartMergedDataModel(notifies: $notifies, appVer: $appVer, term: $term)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is AppStartMergedDataModel &&
      other.notifies == notifies &&
      listEquals(other.appVer, appVer) &&
      other.term == term;
  }

  @override
  int get hashCode => notifies.hashCode ^ appVer.hashCode ^ term.hashCode;
} 
