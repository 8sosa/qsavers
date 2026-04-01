import 'package:slide_countdown/slide_countdown.dart';

import '../../../export.dart';

class CountDownWidget extends StatefulWidget {
  final DateTime? time;
  final TextStyle? textStyle;

  const CountDownWidget({super.key, this.time, this.textStyle});

  @override
  State<CountDownWidget> createState() => _CountDownWidgetState();
}

class _CountDownWidgetState extends State<CountDownWidget>
    with SingleTickerProviderStateMixin {
  late Duration timerDuration;
  late Timer timer;
  int sec = 0;
  Duration countdownDuration = Duration();
  AnimationController? _controller;
  Animation<Offset>? _slideAnimation;
  @override
  void initState() {
    startCountdown();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(0.0, 1.0),
    ).animate(CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeInOut,
    ));
    //   final startTimer = widget.time;
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

  void startCountdown() {
    const oneSecond = Duration(seconds: 1);
    Timer.periodic(oneSecond, (timer) {
      setState(() {
        final now = DateTime.now();
        if (widget.time!.isAfter(now)) {
          countdownDuration = widget.time!.difference(now);
        } else {
          countdownDuration = Duration.zero;
          timer.cancel();
        }
      });
    });
  }

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
    String days = '${countdownDuration.inDays}';
    String hours = '${countdownDuration.inHours.remainder(24)}';
    String minutes = '${countdownDuration.inMinutes.remainder(60)}';
    String seconds = '${countdownDuration.inSeconds.remainder(60)}';

    int daysInt = int.parse(days);
    int hoursInt = int.parse(hours);
    int minutesInt = int.parse(minutes);
    int secondsInt = int.parse(seconds);
    // Determine visibility based on values
    bool showDays = daysInt > 0;
    bool showHours = hoursInt > 0 || showDays;
    bool showMinutes = minutesInt > 0 || showHours;
    bool showSeconds = secondsInt > 0 || showMinutes;

    double totalWidth = 0;
    if (showDays) totalWidth += margin_37; // Assuming 50 as a placeholder for day unit width
    if (showHours) totalWidth += margin_30; // Assuming 30 as a placeholder for hour unit width
    if (showMinutes) totalWidth += margin_30; // Assuming 30 as a placeholder for minute unit width
    if (showSeconds) totalWidth += margin_40;


    return Container(width: totalWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (showDays) CountdownUnit(value: daysInt, unit: 'd'),
          if (showDays)  Text(":",style: textStyleBodyLarge().copyWith(color: Colors.black,fontWeight: FontWeight.w600),),
          if (showHours) CountdownUnit(value: hoursInt, unit: 'h'),
          if (showHours) Text(":",style: textStyleBodyLarge().copyWith(color: Colors.black,fontWeight: FontWeight.w600),),
          if (showMinutes) CountdownUnit(value: minutesInt, unit: 'm'),
          if (showMinutes) Text(":",style: textStyleBodyLarge().copyWith(color: Colors.black,fontWeight: FontWeight.w600),),
          if (showSeconds) CountdownUnit(value: secondsInt, unit: 's'),
        ]
      ),
    );
  }

  double _calculateWidth() {
    final durationText = _formattedDuration;
    final textPainter = TextPainter(
      text: TextSpan(
          text: durationText,
          style: widget.textStyle ?? TextStyle(fontSize: 10)),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    return textPainter.width;
  }
}

class CountdownUnit extends StatelessWidget {
  final int? value;
  final String? unit;
  final bool? isLast;

  const CountdownUnit({
    Key? key,
    @required this.value,
    this.isLast=false,
    @required this.unit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        '$value$unit',
        style: textStyleBodyLarge().copyWith(color: Colors.black,fontWeight: FontWeight.w600),
      ),
    );
  }
}
// Utility extension method to intersperse elements in a list
extension IterableExtension<T> on Iterable<T> {
  Iterable<T> intersperse(T element) sync* {
    Iterator<T> it = iterator;
    if (!it.moveNext()) return;
    yield it.current;
    while (it.moveNext()) {
      yield element;
      yield it.current;
    }
  }
}