import 'package:e_commerce_app/features/home/product/productmodel.dart';

class ProductService {
  static List<ProductModel> getDealProducts() {
    return [
      ProductModel(
        id: "1",
        title: "Deal Shoes",
        image: "https://via.placeholder.com/150",
        price: 59.99,
      ),
    ];
  }

  static List<ProductModel> getTrendingProducts() {
    return [
      ProductModel(
        id: "2",
        title: "Trending Jacket",
        image: "https://via.placeholder.com/150",
        price: 89.99,
      ),
    ];
  }

  static List<ProductModel> getFeaturedProducts() {
    return [
      ProductModel(
        id: "3",
        title: "Featured Watch",
        image: "https://via.placeholder.com/150",
        price: 120.00,
      ),
    ];
  }

  static List<ProductModel> getNewArrivalProducts() {
    return [
      ProductModel(
        id: "4",
        title: "New Arrival Bag",
        image: "https://via.placeholder.com/150",
        price: 75.00,
      ),
    ];
  }
}