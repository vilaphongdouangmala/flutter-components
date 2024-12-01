import 'package:intl/intl.dart';

extension StringExtension on String {
  DateTime strToDate({String format = 'yyyy-MM-dd'}) {
    try {
      return DateFormat(format).parse(this).toLocal();
    } catch (e) {
      return DateTime.now();
    }
  }

  String formatStringDateTime({
    String format = 'yyyy-MM-ddTHH:mm:ss',
    bool isEndTime = false,
  }) {
    DateTime dateTime = DateTime.parse(this).toLocal();
    return isEndTime
        ? DateTime(dateTime.year, dateTime.month, dateTime.day, 23, 59, 0)
            .toLocal()
            .toIso8601String()
        : dateTime.toIso8601String();
  }

  String formatStringDate({String format = 'yyyy-MM-dd'}) {
    try {
      return DateFormat(format).format(DateTime.parse(this).toLocal());
    } catch (e) {
      return 'INVALID DATE';
    }
  }
}

extension ToDate on DateTime {
  String toStringDate({String format = 'yyyy-MM-dd'}) {
    return DateFormat(format).format(toLocal());
  }
}

String jsonDateRangeWithTime({required String from, required String to}) {
  DateTime? fromDateTime =
      from.isNotEmpty ? DateTime.parse(from).toLocal() : null;
  DateTime? toDateTime = to.isNotEmpty ? DateTime.parse(to).toLocal() : null;

  // Convert to datetime formats
  String formattedDateTimeFrom =
      fromDateTime != null ? fromDateTime.toIso8601String() : '';
  String formattedDateTimeTo = toDateTime != null
      ? DateTime(toDateTime.year, toDateTime.month, toDateTime.day, 23, 59, 0)
          .toIso8601String()
      : '';
  return "$formattedDateTimeFrom,$formattedDateTimeTo";
}

bool validateDateTimeRange({
  required String from,
  required String to,
}) {
  if (from.isEmpty || to.isEmpty) {
    return true;
  }
  DateTime fromDate = from.strToDate();
  DateTime toDate = to.strToDate();
  if (toDate.isBefore(fromDate) || fromDate.isAfter(toDate)) {
    return false;
  } else {
    return true;
  }
}

extension DateTimeExtensions on DateTime {
  static String locale() {
    return Intl.getCurrentLocale();
  }

  DateTime change(int year, int month, int day) {
    return DateTime(year, month, day, hour, minute, second);
  }

  static DateTime initWith(int hour, int minute) {
    return DateTime(0, 0, 0, hour, minute, 0);
  }

  static DateTime dateWithHour(int hour, int minute) {
    return DateTime(0, 0, 0, hour, minute, 0);
  }

  static DateTime? dateFromISODateString(String? string) {
    if (string == null) return null;
    final formatString = dateFormatFromDateString(string);
    if (formatString == null) return null;
    final dateFormatter = DateFormat(formatString);
    return dateFormatter.parse(string);
  }

  static String? dateFormatFromDateString(String string) {
    final dateString = string.replaceAll('‐', '-');
    const baseDatePattern = r'^[0-9]{4}-[0-9]{2}-[0-9]{2}';
    const baseDateTimePattern = '$baseDatePattern[T][0-9]{2}:[0-9]{2}:[0-9]{2}';
    const patternWithTimezone =
        '$baseDateTimePattern\\+|\\-[0-9]{2}:[0-9]{2}\$';
    const patternWithMilisecond = '$baseDateTimePattern\\.[0-9]+\u0024';
    const patternWithMilisecondZ = '$baseDateTimePattern\\.[0-9]+Z\u0024';
    const patternWithTimezoneMilisecond =
        '$baseDatePattern[T]([0-9]{2}):([0-9]{2}):([0-9]{2})\\.([0-9]+)\\+([0-9]{2})\\:([0-9]{2})';

    if (RegExp('$baseDatePattern\$').hasMatch(dateString)) return 'yyyy-MM-dd';
    if (RegExp('$baseDateTimePattern\$').hasMatch(dateString)) {
      return 'yyyy-MM-ddTHH:mm:ss';
    }
    if (RegExp(patternWithTimezone).hasMatch(dateString)) {
      return 'yyyy-MM-ddTHH:mm:ssxxx';
    }
    if (RegExp(patternWithMilisecond).hasMatch(dateString)) {
      return 'yyyy-MM-ddTHH:mm:ss.SSS';
    }
    if (RegExp(patternWithMilisecondZ).hasMatch(dateString)) {
      return 'yyyy-MM-ddTHH:mm:ss.SSSZ';
    }
    if (RegExp(patternWithTimezoneMilisecond).hasMatch(dateString)) {
      return 'yyyy-MM-ddTHH:mm:ss.SSSxxx';
    }
    return null;
  }

  String toShortDateString() {
    return DateFormat('yyyy-MM-dd').format(this);
  }

  String toShortDateTimeString() {
    return DateFormat('yyyy-MM-dd HH:mm').format(this);
  }

  String toDateChristianEra() {
    return DateFormat('yyyy/MM/dd').format(this);
  }

  String toDateTimeString() {
    return DateFormat('yyyy-MM-ddTHH:mm:ss').format(this);
  }

  String toDateTimeMilliStringUTC() {
    return DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').format(toUtc());
  }

  String toTimeString() {
    return DateFormat('HH:mm').format(this);
  }

  String toLocalizedWeekDayDateMonthYear() {
    return DateFormat('EEE dd MMM yyyy', locale()).format(this);
  }

  String toLocalizedWeekDayDateWithDayAndMonth() {
    return DateFormat('EEE dd/MM', locale()).format(this);
  }

  String toLocalizedTime() {
    return DateFormat('HH:mm a', locale()).format(this);
  }

  String toLocalizedMonthYear() {
    return DateFormat('MMMM yyyy', locale()).format(this);
  }

  String toLocalizedDayMonthYear() {
    return DateFormat('d MMM yyyy', locale()).format(this);
  }

  String toLocalizedWeekDay() {
    return DateFormat('EEEE', locale()).format(this);
  }

  String toLocalizedDayDateMonthYearHourMin() {
    return DateFormat('EEEE dd MMM yyyy HH:mm', locale()).format(this);
  }

  DateTime combineWithTime(DateTime time) {
    return DateTime(year, month, day, time.hour, time.minute, time.second);
  }

  String nowString() {
    return DateFormat('yyyy-MM-ddTHH:mm:ssZ').format(this);
  }

  static DateTime from(String isoDateString) {
    return DateFormat('yyyy-MM-ddTHH:mm:ssZ').parse(isoDateString);
  }

  DateTime addYear({int value = 1}) {
    return add(Duration(days: value * 365));
  }

  DateTime addMonth({int value = 1}) {
    return add(Duration(days: value * 30));
  }

  DateTime addWeek({int value = 1}) {
    return add(Duration(days: value * 7));
  }

  DateTime addDay({int value = 1}) {
    return add(Duration(days: value));
  }

  DateTime addOneDay() {
    return addDay(value: 1);
  }

  DateTime addTwoDay() {
    return addDay(value: 2);
  }

  DateTime subtractOneDay() {
    return addDay(value: -1);
  }

  DateTime addThreeDays() {
    return addDay(value: 3);
  }

  DateTime subtractThreeDays() {
    return addDay(value: -3);
  }

  bool same(DateTime date, {DateTimeUnit unit = DateTimeUnit.day}) {
    switch (unit) {
      case DateTimeUnit.year:
        return year == date.year;
      case DateTimeUnit.month:
        return month == date.month && year == date.year;
      case DateTimeUnit.day:
        return year == date.year && month == date.month && day == date.day;
      case DateTimeUnit.hour:
        return year == date.year &&
            month == date.month &&
            day == date.day &&
            hour == date.hour;
      case DateTimeUnit.minute:
        return year == date.year &&
            month == date.month &&
            day == date.day &&
            hour == date.hour &&
            minute == date.minute;
      case DateTimeUnit.second:
        return year == date.year &&
            month == date.month &&
            day == date.day &&
            hour == date.hour &&
            minute == date.minute &&
            second == date.second;
      default:
        return false;
    }
  }

  String toDateFormat(String dateFormat) {
    return DateFormat(dateFormat).format(this);
  }

  static DateTime setTimeWithHour(
      int hour, int minute, int second, DateTime date) {
    return DateTime(date.year, date.month, date.day, hour, minute, second);
  }

  DateTime startOfMonth() {
    return DateTime(year, month, 1);
  }

  DateTime endOfMonth() {
    return DateTime(year, month + 1, 0);
  }

  List<DateTime> datesInAMonth() {
    final dates = <DateTime>[];
    var date = startOfMonth();
    final endDate = endOfMonth();

    while (date.isBefore(endDate)) {
      dates.add(date);
      date = date.add(const Duration(days: 1));
    }
    return dates;
  }
}

enum DateTimeUnit {
  year,
  month,
  day,
  hour,
  minute,
  second,
}

String getMonthText(int month) {
  if (month < 1 || month > 12) {
    throw Exception(
        "Invalid month value. Please enter a value between 1 and 12.");
  }
  final dateTime = DateTime(2023, month, 1); // Any year works here
  return DateFormat('MMMM').format(dateTime); // Use 'MMM' for abbreviated month
}

String getStringMinutesFromSeconds(int seconds) {
  final minutes = (seconds / 60).floor();
  final remainingSeconds = seconds % 60;
  return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
}
