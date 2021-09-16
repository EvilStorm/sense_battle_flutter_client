import 'dart:convert';

class UserInfoModel {
  String? identifyId;
  String? email;
  int? joinType;
  int? secureLevel;
  String? nickName;
  int? availability;
  UserInfoModel({
    this.identifyId,
    this.email,
    this.joinType,
    this.secureLevel,
    this.nickName,
    this.availability,
  });

  UserInfoModel copyWith({
    String? identifyId,
    String? email,
    int? joinType,
    int? secureLevel,
    String? nickName,
    int? availability,
  }) {
    return UserInfoModel(
      identifyId: identifyId ?? this.identifyId,
      email: email ?? this.email,
      joinType: joinType ?? this.joinType,
      secureLevel: secureLevel ?? this.secureLevel,
      nickName: nickName ?? this.nickName,
      availability: availability ?? this.availability,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'identifyId': identifyId,
      'email': email,
      'joinType': joinType,
      'secureLevel': secureLevel,
      'nickName': nickName,
      'availability': availability,
    };
  }

  factory UserInfoModel.fromMap(Map<String, dynamic> map) {
    return UserInfoModel(
      identifyId: map['identifyId'],
      email: map['email'],
      joinType: map['joinType'],
      secureLevel: map['secureLevel'],
      nickName: map['nickName'],
      availability: map['availability'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserInfoModel.fromJson(String source) => UserInfoModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserInfoModel(identifyId: $identifyId, email: $email, joinType: $joinType, secureLevel: $secureLevel, nickName: $nickName, availability: $availability)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserInfoModel &&
        other.identifyId == identifyId &&
        other.email == email &&
        other.joinType == joinType &&
        other.secureLevel == secureLevel &&
        other.nickName == nickName &&
        other.availability == availability;
  }

  @override
  int get hashCode {
    return identifyId.hashCode ^ email.hashCode ^ joinType.hashCode ^ secureLevel.hashCode ^ nickName.hashCode ^ availability.hashCode;
  }
}
