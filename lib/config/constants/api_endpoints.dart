
// this class  contains all necessary endpoints, however, every might not be used here
class ApiEndpoints {
  ApiEndpoints._();

  static const String baseUrl = 'https://fakestoreapi.com';

  // endpoint for all products
  static const String getAllProducts = '$baseUrl/products';

  // for a single product

  static const String getSingleProductById = '$baseUrl/:productId';

  // for all categories
  static const String getAllCategories = '$getAllProducts/categories';
}
