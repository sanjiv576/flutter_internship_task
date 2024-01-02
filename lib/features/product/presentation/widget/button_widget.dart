
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  ButtonWidget({
    super.key,
    required this.ic,
    required this.onPress,
  });

  final IconData ic;
  VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.pink,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: onPress,
        color: Colors.white,
        icon: Icon(ic),
      ),
    );
  }
}
