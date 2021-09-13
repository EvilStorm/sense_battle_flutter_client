import 'package:intl/intl.dart';


class AboutDate {

  final dateFormat = new DateFormat('yyyy-MM-dd');
  final dateFormatMMdd = new DateFormat('yyyy\nMM/dd');
  final dateFormatMd = new DateFormat('MM/dd');

  static final AboutDate _singleton = AboutDate._internal();

  factory AboutDate() {
    return _singleton;
  }

  AboutDate._internal();
}
