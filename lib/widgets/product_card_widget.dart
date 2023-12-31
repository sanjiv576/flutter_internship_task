import 'package:flutter/material.dart';

import '../router/app_routes.dart';

class ProductCard extends StatelessWidget {
  ProductCard({
    super.key,
    required this.product,
  });

  // Map<String, dynamic> product;
  var product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('Produt title: ${product.title}');

        Navigator.pushNamed(context, AppRoutes.singleProductRoute,
            arguments: product);
      },
      child: Card(
        shadowColor: Colors.black,
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 8,
              child: Image.network(
                product.image,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                (product.title as String).substring(0, 10),
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
              child: Text(
                '\$${product.price}',
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.green,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
