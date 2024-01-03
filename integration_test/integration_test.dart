import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:online_store/config/router/app_routes.dart';

import 'package:online_store/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets("Home Test", (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(find.text("Product categories"), findsWidgets);
    expect(find.text("All Products"), findsWidgets);

    expect(find.byIcon(Icons.shopping_cart_checkout), findsOneWidget);
  });
}
