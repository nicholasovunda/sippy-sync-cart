import 'package:sippy_cart_sharing/feature/product/data/local/test_products.dart';
import 'package:sippy_cart_sharing/feature/product/domain/product.dart';

abstract class ProductRepository {
  Product? getProduct(String id);
  Future<List<Product>> fetchProductList();
  Stream<List<Product>> watchProductList();
  Future<Product?> fetchProduct(String id);
  Stream<Product?> watchProduct(String id);
  Future<List<Product>> searchProductList(String query);
}

class LocalRepository implements ProductRepository {
  final _products = List<Product>.from(testProducts);
  static Product? _getProduct(List<Product> products, String id) {
    try {
      return products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Product?> fetchProduct(String id) {
    return Future.value(_getProduct(_products, id));
  }

  @override
  Future<List<Product>> fetchProductList() {
    return Future.value(_products);
  }

  @override
  Product? getProduct(String id) {
    return _getProduct(_products, id);
  }

  // Search for products where the title contains the search query
  @override
  Future<List<Product>> searchProductList(String query) async {
    assert(_products.length <= 50);
    final productList = await fetchProductList();
    return productList
        .where(
          (product) =>
              product.title.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }

  // Retrieve a specific product by ID
  @override
  Stream<Product?> watchProduct(String id) {
    return watchProductList().map((products) => _getProduct(products, id));
  }

  @override
  Stream<List<Product>> watchProductList() {
    return Stream.value(_products);
  }
}
