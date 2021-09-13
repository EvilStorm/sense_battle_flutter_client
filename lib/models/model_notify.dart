import 'dart:convert';

class NotifyModel {
  int id;
  String title;
  String message;
  bool appStop;
  bool important;
  DateTime createdAt;
  NotifyModel({
    required this.id,
    required this.title,
    required this.message,
    required this.appStop,
    required this.important,
    required this.createdAt,
  });

  

  NotifyModel copyWith({
    int? id,
    String? title,
    String? message,
    bool? appStop,
    bool? important,
    DateTime? createdAt,
  }) {
    return NotifyModel(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      appStop: appStop ?? this.appStop,
      important: important ?? this.important,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'appStop': appStop,
      'important': important,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory NotifyModel.fromMap(Map<String, dynamic> map) {
    return NotifyModel(
      id: map['id'],
      title: map['title'],
      message: map['message'],
      appStop: map['appStop'],
      important: map['important'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory NotifyModel.fromJson(String source) => NotifyModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NotifyModel(id: $id, title: $title, message: $message, appStop: $appStop, important: $important, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is NotifyModel &&
      other.id == id &&
      other.title == title &&
      other.message == message &&
      other.appStop == appStop &&
      other.important == important &&
      other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      message.hashCode ^
      appStop.hashCode ^
      important.hashCode ^
      createdAt.hashCode;
  }
}
