import 'package:intl/intl.dart';

convertMillisecondsToTimeAgo(int milliseconds) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(milliseconds);
  int difference = DateTime.now().millisecondsSinceEpoch - milliseconds;
  String timeAgo = formatTimeAgo(difference);
  return timeAgo;
}

String millisecondsToCustomDateFormat(int millisecondsSinceEpoch) {
  DateTime dateTime =
      DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
  DateTime localDateTime = dateTime.toLocal();

  // Get the day, month, and year
  String day = localDateTime.day.toString().padLeft(2, '0');
  String month = _getMonthName(localDateTime.month);
  String year = localDateTime.year.toString();

  return '$day/$month/$year';
}

String _getMonthName(int month) {
  switch (month) {
    case DateTime.january:
      return 'January';
    case DateTime.february:
      return 'February';
    case DateTime.march:
      return 'March';
    case DateTime.april:
      return 'April';
    case DateTime.may:
      return 'May';
    case DateTime.june:
      return 'June';
    case DateTime.july:
      return 'July';
    case DateTime.august:
      return 'August';
    case DateTime.september:
      return 'September';
    case DateTime.october:
      return 'October';
    case DateTime.november:
      return 'November';
    case DateTime.december:
      return 'December';
    default:
      return '';
  }
}

String formatTimeAgo(int difference) {
  if (difference < 0) {
    return 'future';
  }

  int seconds = difference ~/ 1000;
  int minutes = seconds ~/ 60;
  int hours = minutes ~/ 60;
  int days = hours ~/ 24;

  if (days > 0) {
    return '$days day${days == 1 ? '' : 's'} ago';
  } else if (hours > 0) {
    return '$hours hour${hours == 1 ? '' : 's'} ago';
  } else if (minutes > 0) {
    return '$minutes minute${minutes == 1 ? '' : 's'} ago';
  } else {
    return 'a few seconds ago';
  }
}

List<int> convertMs(int milliseconds) {
  // Convert milliseconds to days, hours, minutes, and seconds
  int days = (milliseconds ~/ (24 * 60 * 60 * 1000));
  int hours = ((milliseconds % (24 * 60 * 60 * 1000)) ~/ (60 * 60 * 1000));
  int minutes = (((milliseconds % (24 * 60 * 60 * 1000)) % (60 * 60 * 1000)) ~/
      (60 * 1000));
  int seconds = ((((milliseconds % (24 * 60 * 60 * 1000)) % (60 * 60 * 1000)) %
          (60 * 1000)) ~/
      1000);
  return [days, hours, minutes, seconds];
}

String formatMillisecondsToHhMm(milliseconds) {
  DateTime dateTime =
      DateTime.fromMillisecondsSinceEpoch(int.parse(milliseconds));
  DateTime now = DateTime.now();
  String timeFormat = '';

  if (dateTime.year == now.year &&
      dateTime.month == now.month &&
      dateTime.day == now.day) {
    timeFormat = 'Today';
  } else {
    timeFormat = DateFormat('MMM d, yyyy').format(dateTime);
  }

  String timeString = DateFormat('h:mm a').format(dateTime);
  return '$timeFormat, $timeString';
}
