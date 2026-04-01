import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class HeartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(size.width / 2, size.height / 4);
    path.quadraticBezierTo(
        size.width * 3 / 4, 0, size.width, size.height / 2);
    path.quadraticBezierTo(
        size.width * 3 / 4, size.height, size.width / 2, size.height);
    path.quadraticBezierTo(
        size.width / 4, size.height, 0, size.height / 2);
    path.quadraticBezierTo(
        size.width / 4, 0, size.width / 2, size.height / 4);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class HeartWidget extends StatelessWidget {
  final double size;

  const HeartWidget({required this.size});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: HeartPainter(),
    );
  }
}




class FloatingHearts extends StatefulWidget {
  @override
  _FloatingHeartsState createState() => _FloatingHeartsState();
}

class _FloatingHeartsState extends State<FloatingHearts>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        return Stack(
          children: List.generate(20, (index) {
            final delay = index * 0.1;
            return AnimatedHeart(
              animation: _controller,
              delay: delay,
              index: index,
              maxWidth: width,
            );
          }),
        );
      },
    );
  }
}

class AnimatedHeart extends StatelessWidget {
  final Animation<double> animation;
  final double delay;
  final int index;
  final double maxWidth;

  const AnimatedHeart({
    required this.animation,
    required this.delay,
    required this.index,
    required this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final value = (animation.value + delay) % 1.0;
        final offset = Offset(0, -value * 300);
        final opacity = (1 - value).clamp(0.0, 1.0);
        final size = (1 - value) * 24.0 + 24.0;
        final leftPosition = (index / 20.0) * maxWidth;

        return Positioned(
          left: leftPosition,
          bottom: 0,
          child: Transform.translate(
            offset: offset,
            child: Opacity(
              opacity: opacity,
              child: HeartWidget(size: size),
            ),
          ),
        );
      },
    );
  }
}


