import 'package:intl/intl.dart';

class DateConverter {
  static String formatDate(DateTime dateTime) {
    return DateFormat("dd MMMM, yyyy").format(dateTime);
  }

  static String estimatedDate(DateTime dateTime) {
    return DateFormat('dd MMM').format(dateTime);
  }

  static String convertStringToDatetime(DateTime dateTime) {
    return DateFormat("yyyy-MM-dd").format(dateTime);
  }


  static String convertStringToDatetimeWeekDay(DateTime dateTime) {
    return DateFormat('EEEE').format(dateTime);
  }

  static String storyStringToDatetime(DateTime dateTime) {
    return DateFormat("dd MMMM, yyyy").format(dateTime);
  }

  static String sendDateToServer(DateTime dateTime) {
    return DateFormat("yyyy/MM/dd").format(dateTime);
  }

  static DateTime isoStringToLocalDate(String dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTime).toLocal();
  }
  static String isoStringToLocalTimeOnly(String dateTime) {
    return DateFormat("hh:mm aa").format(isoStringToLocalDate(dateTime));
  }
  static String stringToLocalTimeOnly(String dateTime) {
    return DateFormat("hh:mm aa").format(DateTime.parse(dateTime).toLocal());
  }
  static String appointmentUpdate(String dateTime) {
    var now = DateTime.now();
    DateTime time = DateTime(now.year,now.month,now.day,int.parse(dateTime.substring(0,2)),int.parse(dateTime.substring(3,5)));
    return DateFormat("hh:mm aa").format(time);
  }
  static String filterTimeUpdate(String hour,String minute) {
    var now = DateTime.now();
    DateTime time = DateTime(now.year,now.month,now.day,int.parse(hour),int.parse(minute));
    return DateFormat("hh:mm aa").format(time);
  }

  static String isoStringToLocalDateOnly(String dateTime) {
    return DateFormat('dd:MM:yy').format(isoStringToLocalDate(dateTime));
  }


  static String localDateToIsoString(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime.toUtc());
  }


  static String timeFormatter (double time) {
    Duration duration = Duration(milliseconds: time.round());
    return [duration.inMinutes, duration.inSeconds].map((seg) => seg.remainder(60).toString().padLeft(2, '0')).join(':');
  }


}
