enum PasswordLevel { NONE, WEEK, NORMAL, STRONG }

class PasswordLevelModel {
  String? message;
  PasswordLevel level = PasswordLevel.NONE;
}
