import '../../export.dart';

class TextViewLimit extends StatelessWidget {
  final String? text;
  final TextStyle? textStyle;
  final TextAlign textAlign;
  final int maxLines;
  final int charLimit;

  const TextViewLimit({
    Key? key,
    this.text,
    this.textStyle,
    this.maxLines = 5,
    this.textAlign = TextAlign.start,
    this.charLimit = 20,
  }) : super(key: key);

  String formatText(String text) {
    if (text.length <= charLimit) return text;
    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      if ((i + 1) % charLimit == 0) {
        buffer.write('\n');
      }
    }
    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      formatText(text ?? ""),
      style: textStyle,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      textAlign: textAlign,
    );
  }
}
