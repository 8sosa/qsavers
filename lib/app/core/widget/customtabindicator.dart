import '../../export.dart';

class CustomTabIndicator extends Decoration {
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CustomTabIndicatorPainter(this, onChanged);
  }
}

class _CustomTabIndicatorPainter extends BoxPainter {
  final CustomTabIndicator decoration;

  _CustomTabIndicatorPainter(this.decoration, VoidCallback? onChanged)
      : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final paint = Paint();
    paint.color = Colors.white;
    paint.style = PaintingStyle.fill;

    final Rect rect = Offset(offset.dx, configuration.size!.height - 4) &
    Size(configuration.size!.width, 4);

    canvas.drawRRect(
        RRect.fromRectAndRadius(rect, Radius.circular(2.0)), paint);
  }
}
