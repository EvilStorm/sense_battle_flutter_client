import 'package:http_interceptor/http_interceptor.dart';
import 'package:intl/intl.dart';
import 'package:sense_battle/utils/Print.dart';

class LogginInterceptor implements InterceptorContract {
  DateFormat dateFormat = DateFormat('HH:mm:ss.sss');
  bool isShowLog = true;

  String getTime() {
    return dateFormat.format(DateTime.now());
  }

  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    if (isShowLog) {
      Print.i("${getTime()} <<<<<<<<<<<<<<  Request  >>>>>>>>>>>>>>>>>>>>>>>");
      Print.api("${getTime()} Request Url: ${data.url}");
      Print.api("${getTime()} Request header: ${data.headers}");
      Print.api("${getTime()} Request Body: ${data.body}");
      Print.i("${getTime()} -------------------------------------- ");
    }
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    if (isShowLog) {
      Print.ii("${getTime()} >>>>>>>>>>>>>>>>>> Response <<<<<<<<<<<<<<<<<<<<<<<<");
      Print.api2("${getTime()} Response Url: (${data.statusCode}) ${data.url}");
      Print.api2("${getTime()} Response data: ${data.body.toString()}");
      Print.ii("${getTime()} -------------------------------------- ");
    }

    return data;
  }
}
