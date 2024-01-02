import 'package:flutter/material.dart';

import 'category_card_widget.dart';

class CategoriesWidget extends StatelessWidget {
  CategoriesWidget({
    super.key,
    required Future<List>? categoriesFuture,
    required SizedBox horizontalGap,
    required SizedBox verticalGap,
  })  : _categoriesFuture = categoriesFuture,
        _horizontalGap = horizontalGap,
        _verticalGap = verticalGap;

  final Future<List>? _categoriesFuture;
  final SizedBox _horizontalGap;
  final SizedBox _verticalGap;

  // final List<String> _icons = [
  //   '',
  //   '',
  //   '',
  //   '',

  // ];
  final _icons = [
    Icons.watch,
    Icons.diamond,
    Icons.man,
    Icons.female,
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: FutureBuilder<List<dynamic>>(
        future: _categoriesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text('No categories available.');
          } else {
            return Row(
              children: [
                for (int i = 0; i < snapshot.data!.length; i++) ...{
                  // Container(
                  //   height: 100,
                  //   width: 100,
                  //   color: Colors.black,

                  // ),
                  CategoryCard(
                      verticalGap: _verticalGap,
                      data: snapshot.data![i],
                      icon: _icons[i]),
                  _horizontalGap,
                }
              ],
            );

        
          }
        },
      ),
    );
  }
}

