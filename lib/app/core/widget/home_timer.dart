
import '../../export.dart';

class CountDownWidgetHomeScreen extends StatefulWidget {
  final DateTime? time;
  final TextStyle? textStyle;

  const CountDownWidgetHomeScreen({super.key, this.time, this.textStyle});

  @override
  State<CountDownWidgetHomeScreen> createState() => _CountDownWidgetState();
}

class _CountDownWidgetState extends State<CountDownWidgetHomeScreen> {
  late Duration timerDuration;
  late Timer timer;
  int sec = 0;

  @override
  void initState() {
    final startTimer = widget.time;
    final currentTime = DateTime.now();
    if (startTimer == null ||
        currentTime.isAtSameMomentAs(startTimer) ||
        currentTime.isAfter(startTimer)) {
      timerDuration = const Duration();
    } else {
      final difference = startTimer.difference(currentTime);
      timerDuration = difference;
    }

    _startTimer();
    super.initState();
  }

  void _startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      timer = t;
      sec = timerDuration.inSeconds;
      if (sec > 0) {
        sec -= 1;
        timerDuration = Duration(seconds: sec);
        if (mounted) {
          setState(() {});
        }
      } else {
        timer.cancel();
      }
    });
  }

  // String get _formattedDuration {
  //   var seconds = timerDuration.inSeconds;
  //   final days = seconds ~/ Duration.secondsPerDay;
  //   seconds -= days * Duration.secondsPerDay;
  //   final hours = seconds ~/ Duration.secondsPerHour;
  //   seconds -= hours * Duration.secondsPerHour;
  //   final minutes = seconds ~/ Duration.secondsPerMinute;
  //   seconds -= minutes * Duration.secondsPerMinute;
  //
  //   final List<String> tokens = [];
  //
  //   tokens.add('$days${days > 1 ? 'd' : 'd'}');
  //
  //   if (tokens.isNotEmpty || hours != 0) {
  //     tokens.add('$hours${hours > 1 ? 'h' : 'h'}');
  //   }
  //   if (tokens.isNotEmpty || minutes != 0) {
  //     tokens.add('${minutes}m');
  //   }
  //   tokens.add('${seconds}s');
  //
  //   return tokens.join(' : ');
  // }

  String get _formattedDuration {
    var seconds = timerDuration.inSeconds;
    final days = seconds ~/ Duration.secondsPerDay;
    seconds -= days * Duration.secondsPerDay;
    final hours = seconds ~/ Duration.secondsPerHour;
    seconds -= hours * Duration.secondsPerHour;
    final minutes = seconds ~/ Duration.secondsPerMinute;
    seconds -= minutes * Duration.secondsPerMinute;

    final List<String> tokens = [];

    if (days > 0) {
      tokens.add('$days${days > 1 ? 'd' : 'd'}');
    }

    if (tokens.isNotEmpty || hours != 0) {
      tokens.add('$hours${hours > 1 ? 'h' : 'h'}');
    }
    if (tokens.isNotEmpty || minutes != 0) {
      tokens.add('${minutes}m');
    }
    tokens.add('${seconds}s');

    return tokens.join(' : ');
  }


  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return timerDuration.inSeconds==0?const SizedBox():SizedBox(
      width: _calculateWidth(), //110
      child: TextView(
        text: _formattedDuration,
        textStyle: widget.textStyle ??
            textStyleBodyLarge().copyWith(
                color: AppColors.gradient2nd,
                fontWeight: FontWeight.w600,
                fontSize: 10),
        maxLines: 2,
      ),
    );
  }

  double _calculateWidth() {
    final durationText = _formattedDuration;
    final textPainter = TextPainter(
      text: TextSpan(text: durationText, style: widget.textStyle ?? TextStyle(fontSize: 10)),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    return textPainter.width + 25;
  }
}
