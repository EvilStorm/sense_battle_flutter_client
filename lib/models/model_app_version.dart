import 'dart:convert';

class AppVersionModel {
  int version;
  String message;
  bool nessesary;
  AppVersionModel({
    required this.version,
    required this.message,
    required this.nessesary,
  });

  AppVersionModel copyWith({
    int? version,
    String? message,
    bool? nessesary,
  }) {
    return AppVersionModel(
      version: version ?? this.version,
      message: message ?? this.message,
      nessesary: nessesary ?? this.nessesary,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'version': version,
      'message': message,
      'nessesary': nessesary,
    };
  }

  factory AppVersionModel.fromMap(Map<String, dynamic> map) {
    return AppVersionModel(
      version: map['version'],
      message: map['message'],
      nessesary: map['nessesary'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AppVersionModel.fromJson(String source) => AppVersionModel.fromMap(json.decode(source));

  @override
  String toString() => 'AppVersionModel(version: $version, message: $message, nessesary: $nessesary)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppVersionModel && other.version == version && other.message == message && other.nessesary == nessesary;
  }

  @override
  int get hashCode => version.hashCode ^ message.hashCode ^ nessesary.hashCode;
}
