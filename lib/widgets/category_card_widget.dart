
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required SizedBox verticalGap,
    required String data,
    required IconData icon,
  })  : _verticalGap = verticalGap,
        _data = data,
        _icon = icon;

  final SizedBox _verticalGap;
  final String _data;
  final IconData _icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          // backgroundColor: Colors.black,
          child: Icon(_icon),
        ),
        _verticalGap,
        Text(_data)
      ],
    );
  }
}