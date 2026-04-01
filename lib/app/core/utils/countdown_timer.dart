import 'package:quantity_savers/app/export.dart';

class CountdownTimer {
  late Timer _timer;
  late DateTime _endTime;

  CountdownTimer();

  void start(int endDateMillis, Function(String) onUpdate) {
    _endTime = DateTime.fromMillisecondsSinceEpoch(endDateMillis);
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      onUpdate(_updateTimerText());
    });
  }

  String _updateTimerText() {
    Duration remainingTime = _endTime.difference(DateTime.now());
    if (remainingTime.inSeconds <= 0) {
      _timer.cancel();
      return "";
    } else {
      int days = remainingTime.inDays;
      int hours = remainingTime.inHours.remainder(24);
      int minutes = remainingTime.inMinutes.remainder(60);
      int seconds = remainingTime.inSeconds.remainder(60);
      String daysStr = days > 0 ? "${days}d : " : "";
      return "$daysStr${hours}h : ${minutes}m : ${seconds}s";
    }
  }

  void stop() {
    _timer.cancel();
  }
}
