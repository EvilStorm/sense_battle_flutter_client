import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:sense_battle/models/model_notify.dart';

class AppStartNotifyModel {
  NotifyModel? appStopNotify;
  List<NotifyModel>? normalNotifies;
  AppStartNotifyModel({
    this.appStopNotify,
    this.normalNotifies,
  });
  
  

  AppStartNotifyModel copyWith({
    NotifyModel? appStopNotify,
    List<NotifyModel>? normalNotifies,
  }) {
    return AppStartNotifyModel(
      appStopNotify: appStopNotify ?? this.appStopNotify,
      normalNotifies: normalNotifies ?? this.normalNotifies,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'appStopNotify': appStopNotify?.toMap(),
      'normalNotifies': normalNotifies?.map((x) => x.toMap()).toList(),
    };
  }

  factory AppStartNotifyModel.fromMap(Map<String, dynamic> map) {
    return AppStartNotifyModel(
      appStopNotify: map['appStopNotify']!=null ?NotifyModel.fromMap(map['appStopNotify']) :null,
      normalNotifies: List<NotifyModel>.from(map['normalNotifies']?.map((x) => NotifyModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory AppStartNotifyModel.fromJson(String source) => AppStartNotifyModel.fromMap(json.decode(source));

  @override
  String toString() => 'AppStartNotifyModel(appStopNotify: $appStopNotify, normalNotifies: $normalNotifies)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is AppStartNotifyModel &&
      other.appStopNotify == appStopNotify &&
      listEquals(other.normalNotifies, normalNotifies);
  }

  @override
  int get hashCode => appStopNotify.hashCode ^ normalNotifies.hashCode;
}
