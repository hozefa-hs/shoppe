class CartModel {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final int quantity;

  CartModel({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.price,
    this.quantity = 1,
  });

  // Convert CartModel to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'price': price,
      'quantity': quantity,
    };
  }

  // Create a CartModel object from a Firestore document
  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      price: (map['price'] as num?)?.toDouble() ?? 0.0,
      quantity: map['quantity'] ?? 0,
    );
  }
}
