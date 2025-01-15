import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shoppe/models/cart_model.dart';

class CartController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add to cart product
  Future<void> addProduct(CartModel product) async {
    try {
      final userId = FirebaseAuth
          .instance.currentUser!.uid; // Get the authenticated user's UID

      // Fetch the user's cart document
      final cartDoc = await _firestore.collection('cart').doc(userId).get();

      if (cartDoc.exists) {
        // Cart exists, check for duplicates
        final List<dynamic> items = cartDoc.data()?['items'] ?? [];
        bool productExists = false;

        // Update the quantity if the product already exists
        for (var item in items) {
          if (item['productId'] == product.id) {
            item['quantity'] += product.quantity; // Update quantity
            productExists = true;
            break;
          }
        }

        if (productExists) {
          // Update the cart document with the modified items
          await _firestore.collection('cart').doc(userId).update({
            'items': items,
          });
        } else {
          // Add the new product to the items array
          await _firestore.collection('cart').doc(userId).update({
            'items': FieldValue.arrayUnion([product.toMap()]),
          });
        }
      } else {
        // Cart does not exist, create a new one with the product
        await _firestore.collection('cart').doc(userId).set({
          'items': [product.toMap()],
        });
      }
    } catch (e) {
      throw Exception('Error adding product to cart: $e');
    }
  }

  Stream<List<CartModel>> getProducts() {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;

      // Stream the cart document for the logged-in user
      return _firestore
          .collection('cart')
          .doc(userId)
          .snapshots()
          .map((snapshot) {
        if (snapshot.exists) {
          final data = snapshot.data()!;
          final items = data['items'] as List<dynamic>? ?? [];
          return items.map((item) => CartModel.fromMap(item)).toList();
        } else {
          return []; // Return an empty list if the cart doesn't exist
        }
      });
    } catch (e) {
      throw Exception('Error fetching products for cart: $e');
    }
  }

  // Delete Product
  Future<void> deleteProduct(String productId) async {
    try {
      await _firestore.collection('cart').doc(productId).delete();
    } catch (e) {
      throw Exception('Error deleting product from cart: $e');
    }
  }
}
