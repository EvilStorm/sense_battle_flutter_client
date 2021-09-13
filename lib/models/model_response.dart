import 'dart:convert';

class ResponseModel {
  String status;
  int code;
  dynamic errors;
  dynamic data;
  ResponseModel({
    required this.status,
    required this.code,
    required this.errors,
    required this.data,
  });

  

  ResponseModel copyWith({
    String? status,
    int? code,
    dynamic? errors,
    dynamic? data,
  }) {
    return ResponseModel(
      status: status ?? this.status,
      code: code ?? this.code,
      errors: errors ?? this.errors,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'code': code,
      'errors': errors,
      'data': data,
    };
  }

  factory ResponseModel.fromMap(Map<String, dynamic> map) {
    return ResponseModel(
      status: map['status'],
      code: map['code'],
      errors: map['errors'],
      data: map['data'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseModel.fromJson(String source) => ResponseModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ResponseModel(status: $status, code: $code, errors: $errors, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ResponseModel &&
      other.status == status &&
      other.code == code &&
      other.errors == errors &&
      other.data == data;
  }

  @override
  int get hashCode {
    return status.hashCode ^
      code.hashCode ^
      errors.hashCode ^
      data.hashCode;
  }
}
