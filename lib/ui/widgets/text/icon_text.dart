import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  final bool reversed;
  final bool adaptiveIconSize;
  final String text;
  final IconData icon;
  final TextStyle style;

  const IconText({
    this.reversed = false,
    this.adaptiveIconSize = true,
    required this.text,
    required this.icon,
    required this.style,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     if (reversed) {
      return Text.rich(
        TextSpan(
          children: [
            TextSpan(text: '$text '),
            WidgetSpan(
              child: Icon(
                icon,
                size: adaptiveIconSize
                    ? style.fontSize
                    : IconTheme.of(context).size,
              ),
            ),
          ],
        ),
        style: style,
      );
    } else {
      return Text.rich(
        TextSpan(
          children: [
            WidgetSpan(
              child: Icon(
                icon,
                size: adaptiveIconSize
                    ? style.fontSize
                    : IconTheme.of(context).size,
              ),
            ),
            TextSpan(text: ' $text'),
          ],
        ),
        style: style,
      );
    }
  }
}
