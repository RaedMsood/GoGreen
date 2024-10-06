import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

extension ParseStringTothousandsNumber on String {
  /// Convert a string to number or throw an exception if can't convert it.
  /// [removeComma] is used to remove the comma from the string before converting it to number.
  ///
  /// For example:
  ///
  /// '1000' will be converted to 1000,
  ///
  /// '1,000' will be converted to 1000 if [removeComma] is true
  int toInt({bool removeComma = true}) {
    String value = removeComma ? replaceAll(',', '') : this;
    return int.parse(value);
  }

  /// Check if the string is a http url.
  bool get isHttpUrl {
    try {
      final url = Uri.parse(this);
      return url.scheme == 'http' || url.scheme == 'https';
    } catch (e) {
      return false;
    }
  }

  /// Check if the string is a asset path.
  bool get isAssetPath {
    return trim().startsWith('asset') || trim().startsWith('assets');
  }

  // format string date to '01/01/2024 - 02:30 AM'
  String get formatDate {
    List<String> date = split(' ');
    List<String> datePart = date[0].split('-');
    List<String> timePart = date[1].split(':');
    TimeOfDay timeOfDay = TimeOfDay(
      hour: int.parse(timePart[0]),
      minute: int.parse(timePart[1]),
    );
    String hour = timeOfDay.hourOfPeriod.toString();
    String minute = timeOfDay.minute.toString();
    hour = hour.padLeft(2, '0');
    minute = minute.padLeft(2, '0');
    String period = timeOfDay.period == DayPeriod.am ? 'AM' : 'PM';
    String value =
        '${datePart[2]}/${datePart[1]}/${datePart[0]} - $hour:$minute $period';
    return value;
  }

//convert the DateTime.now().toIso8601String() to a readable format
  String getTime() {
    DateTime dateTime = DateTime.parse(this);
    return DateFormat('hh:mm a').format(dateTime);
  }
}

extension ColorExtension on String {
  /// Convert a string hex color to Color object if the string is a valid hex color, otherwise throws an exception.
  Color toColor() {
    String formattedColor = toUpperCase().replaceAll('#', '');
    // if (formattedColor.length == 6) {
    formattedColor = 'FF$formattedColor';
    // }
    return Color(int.parse(formattedColor, radix: 16));
  }

  /// Convert a string hex color to Color object if the string is a valid hex color, otherwise returns null.
  toColorOrNull() {
    try {
      return toColor();
    } catch (e) {
      return null;
    }
  }
}

String dayHour(String date) {
  if (date.isEmpty) return '';

  try {
    return '${todayYesterdayOrDayOfWeek(date)}، ${DateFormat('hh:mm').format(localDateTime(date))} ${amPm(date)}';
  } catch (ex) {
    return date;
  }
}

String dayOfWeek(String date) {
  return DateFormat('EEEE', 'ar-YE').format(DateTime.parse(date));
}

String monthName(String date, {String local = 'ar-YE'}) {
  return DateFormat('MMM', local).format(DateTime.parse(date));
}

String dayDate(String date) {
  if (date.isEmpty) return '';

  try {
    return '${dayOfWeek(date)} ${DateFormat('dd').format(DateTime.parse(date))} ${monthName(date)} ';
  } catch (ex) {
    return '';
  }
}

DateTime localDateTime(String date) {
  return DateFormat('yyyy-MM-dd HH:mm:ss').parse(date, true).toLocal();
}

String todayYesterdayOrDayOfWeek(String date) {
  var todayDate = DateTime.now();
  var yesterdayDate = todayDate.subtract(const Duration(days: 1));
  var datetime = DateTime.parse(date);

  String day = dayOfWeek(date);

  if (datetime.month != todayDate.month || datetime.year != todayDate.year) {
    return dayDate(date);
  }

  if (datetime.day != todayDate.day && datetime.day != yesterdayDate.day) {
    return dayDate(date);
  }

  String today = dayOfWeek(todayDate.toString());
  String yesterday = dayOfWeek(yesterdayDate.toString());

  if (day == today) {
    return 'اليوم';
  }

  if (day == yesterday) {
    return 'امس';
  }

  return dayDate(date);
}

String amPm(String date) {
  return DateFormat('a ', 'ar-YE').format(DateTime.parse(date));
}

DateTime fromTime(TimeOfDay time, {DateTime? dateTime}) {
  var now = dateTime ?? DateTime.now();

  return DateTime(now.year, now.month, now.day, time.hour, time.minute);
}

DateTime fromTimeString(String time, {String? dateTime}) {
  var date = DateTime.now();

  if (dateTime != null) {
    date = DateTime.parse('$dateTime $time');
  }

  return date;
}
