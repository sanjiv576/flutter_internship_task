import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:online_store/features/product/domain/entity/product_entity.dart';
import 'package:online_store/features/product/domain/use_case/product_use_case.dart';
import 'package:online_store/features/product/presentation/viewmodel/product_viewmodel.dart';

import '../../test_data/product_entity_test.dart';
import 'product_unit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<ProductUseCase>(),
])

// dart run build_runner build --delete-conflicting-outputs
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late ProductUseCase mockProductUseCase;
  late ProviderContainer container;
  late List<ProductEntity> productList;

  // command used to build mock file: dart run build_runner build --delete-conflicting-outputs

  // initialization of above properties
  setUpAll(() async {
    mockProductUseCase = MockProductUseCase();
    productList = await getProductTest();

    // make empty call of products
    when(mockProductUseCase.getAllProducts())
        .thenAnswer((_) => Future.value(const Right([])));

    container = ProviderContainer(
      overrides: [
        // override the productUseCase with mock use case
        productViewModelProvider.overrideWith(
          (ref) => ProductViewModel(productUseCase: mockProductUseCase),
        ),
      ],
    );
  });

  test('should get all products ', () async {
    when(mockProductUseCase.getAllProducts())
        .thenAnswer((_) => Future.value(Right(productList)));

    //  call above function
    await container.read(productViewModelProvider.notifier).getAllProducts();

    final productState = container.read(productViewModelProvider);

    // verify the length of menu list is not empty
    expect(productState.products, isNotEmpty);
  });

  tearDownAll(() => container.dispose());
}
