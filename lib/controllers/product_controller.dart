import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';

class ProductController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add Product
  Future<void> addProduct(ProductModel product) async {
    try {
      await _firestore.collection('products').doc(product.id).set(product.toMap());
    } catch (e) {
      throw Exception('Error adding product: $e');
    }
  }

  // Get All Products as a Stream
  Stream<List<ProductModel>> getProducts() {
    try {
      return _firestore.collection('products').snapshots().map((snapshot) =>
          snapshot.docs.map((doc) => ProductModel.fromMap(doc.data())).toList());
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }

  // Update Product
  Future<void> updateProduct(ProductModel product) async {
    try {
      await _firestore.collection('products').doc(product.id).update(product.toMap());
    } catch (e) {
      throw Exception('Error updating product: $e');
    }
  }

  // Delete Product
  Future<void> deleteProduct(String productId) async {
    try {
      await _firestore.collection('products').doc(productId).delete();
    } catch (e) {
      throw Exception('Error deleting product: $e');
    }
  }
}
