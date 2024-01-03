import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:online_store/config/router/app_routes.dart';
import 'package:online_store/features/product/domain/entity/product_entity.dart';
import 'package:online_store/features/product/domain/use_case/product_use_case.dart';
import 'package:online_store/features/product/presentation/viewmodel/product_viewmodel.dart';

import '../../../../../test_data/product_entity_test.dart';
import '../../../../unit_test.dart/product_unit_test.mocks.dart';

class CustomBindings extends AutomatedTestWidgetsFlutterBinding {
  @override
  bool get overrideHttpClient => false;
}

@GenerateNiceMocks([MockSpec<ProductUseCase>()])
void main() {
  CustomBindings();
  TestWidgetsFlutterBinding.ensureInitialized();
  late ProductUseCase mockProductUseCase;
  late List<ProductEntity> productList;

  // command used to build mock file: dart run build_runner build --delete-conflicting-outputs

  setUp(() async {
    mockProductUseCase = MockProductUseCase();
    productList = await getProductTest();
  });

  testWidgets('get all products', (tester) async {
    when(mockProductUseCase.getAllProducts()).thenAnswer(
      (_) => Future.value(
        Right(productList),
      ),
    );
    await tester.pumpAndSettle(const Duration(seconds: 5));

    await tester.pumpWidget(
      
      ProviderScope(
        overrides: [
          productViewModelProvider.overrideWith(
            (ref) => ProductViewModel(
              productUseCase: mockProductUseCase,
            ),
          ),
        ],
        child: MaterialApp(
          initialRoute: AppRoutes.homeRoute,
          routes: AppRoutes.getAppRoutes(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('All Products'), findsNWidgets(4));
  });
}
