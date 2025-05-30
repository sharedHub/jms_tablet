import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateConverter {
  static String getTime(DateTime dt) {
    try {
      final String dtHour =
      dt.hour.toString().length == 1 ? "0${dt.hour}" : dt.hour.toString();
      final String dtMinute = dt.minute.toString().length == 1
          ? "0${dt.minute}"
          : dt.minute.toString();
      final String dtSeconds = dt.second.toString().length == 1
          ? "0${dt.second}"
          : dt.second.toString();
      final String time = "$dtHour:$dtMinute";
      return time;
    } catch (e) {
      debugPrint("error in fuctn ---->> $e");
      return "";
    }
  }

  static String getTimeWith12HourFormat(DateTime dt) {
    try {
      final String dtHour = (dt.hour % 12 == 0 ? 12 : dt.hour % 12).toString();
      final String dtMinute = dt.minute.toString().padLeft(2, '0');
      final String period = dt.hour >= 12 ? "PM" : "AM";
      final String time = "$dtHour:$dtMinute $period";
      return time;
    } catch (e) {
      return "";
    }
  }

  static String getTimeString(String dt) {
    try {
      DateTime dt0 = DateTime.parse(dt);
      final String dtHour = dt0.hour.toString().length == 1
          ? "0${dt0.hour}"
          : dt0.hour.toString();
      final String dtMinute = dt0.minute.toString().length == 1
          ? "0${dt0.minute}"
          : dt0.minute.toString();
      final String time = "$dtHour:$dtMinute";
      return time;
    } catch (e) {
      return "";
    }
  }

  static String getDateTimeWithMonth(DateTime dt) {
    try {
      String monthName = "";
      if (dt.month == 1) {
        monthName = "January";
      } else if (dt.month == 2) {
        monthName = "February";
      } else if (dt.month == 3) {
        monthName = "March";
      } else if (dt.month == 4) {
        monthName = "April";
      } else if (dt.month == 5) {
        monthName = "May";
      } else if (dt.month == 6) {
        monthName = "June";
      } else if (dt.month == 7) {
        monthName = "July";
      } else if (dt.month == 8) {
        monthName = "August";
      } else if (dt.month == 9) {
        monthName = "September";
      } else if (dt.month == 10) {
        monthName = "October";
      } else if (dt.month == 11) {
        monthName = "November";
      } else if (dt.month == 12) {
        monthName = "December";
      }

      return "${dt.day} $monthName ${dt.year}, ${getTime(dt)}";
    } catch (e) {
      return "";
    }
  }

  // static String? formatToGolangCompatibleRFC3339NanoUtc(DateTime? date) {
  //   if (date == null) return null;
  //   return DateFormat("yyyy-MM-ddTHH:mm:ss.SSSSSSSSS+00:00")
  //       .format(DateTime.parse(date.toString()).toUtc());
  // }

  static String? formatToGolangCompatibleRFC3339NanoUtc(DateTime? date) {
    if (date == null) return null;

    final zeroTimeDate = DateTime.utc(date.year, date.month, date.day);
    return DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSSSSSSS'+00:00'")
        .format(zeroTimeDate);
  }

  // static String? formatToGolangCompatibleRFC3339NanoUtc(DateTime? date) {
  //   if (date == null) return null;
  //   final utcDate = date?.toUtc();
  //   return DateFormat("yyyy-MM-dd").format(utcDate!);
  // }

  static String? getDateWithMonth(DateTime? dt) {
    debugPrint(" get Date --> value $dt");
    if (dt == null) return null;
    try {
      String monthName = "";
      if (dt.month == 1) {
        monthName = "01";
      } else if (dt.month == 2) {
        monthName = "02";
      } else if (dt.month == 3) {
        monthName = "03";
      } else if (dt.month == 4) {
        monthName = "04";
      } else if (dt.month == 5) {
        monthName = "05";
      } else if (dt.month == 6) {
        monthName = "06";
      } else if (dt.month == 7) {
        monthName = "07";
      } else if (dt.month == 8) {
        monthName = "08";
      } else if (dt.month == 9) {
        monthName = "09";
      } else if (dt.month == 10) {
        monthName = "10";
      } else if (dt.month == 11) {
        monthName = "11";
      } else if (dt.month == 12) {
        monthName = "12";
      }

      return "${dt.day}/ $monthName /${dt.year}";
    } catch (e) {
      return "";
    }
  }

  static DateTime? parseDateWithMonth(String? dateStr) {
    if (dateStr == null) return null;
    try {
      final List<String> parts = dateStr.split(' ');
      debugPrint("parts --> $parts");
      if (parts.length != 3) return null;

      final int day = int.parse(parts[0]);
      final String monthName = parts[1];
      final int year = int.parse(parts[2]);

      final int month = _monthFromName(monthName);

      if (month == -1) return null;

      return DateTime(year, month, day);
    } catch (e) {
      return null;
    }
  }

  static int _monthFromName(String monthName) {
    switch (monthName) {
      case "January":
        return 1;
      case "February":
        return 2;
      case "March":
        return 3;
      case "April":
        return 4;
      case "May":
        return 5;
      case "June":
        return 6;
      case "July":
        return 7;
      case "August":
        return 8;
      case "September":
        return 9;
      case "October":
        return 10;
      case "November":
        return 11;
      case "December":
        return 12;
      default:
        return -1;
    }
  }
}
