
/// return a String after converting the DateTime to String like : "9:30 AM"
String toAmPm(DateTime time) {
  final int pm = time.hour > 12 ? time.hour - 12 : 12;
  final String pmTime =
      '${pm.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')} PM';
  final String amTime = '${time.toString().substring(11, 16)} AM';

  final String formattedTime = (time.hour >= 12) ? pmTime : amTime;

  return formattedTime;
}

/// returns the current time of the given timezone.
DateTime fromTimeZone(int timezone) {
  timezone.abs();
  final time = DateTime.now().toUtc();
  final now = timezone.isNegative
      ? time.subtract(Duration(seconds: timezone.abs()))
      : time.add(Duration(seconds: timezone));

  return now;
}
