import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoppe/models/category_model.dart';

class CategoryController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Add Category
  Future<void> addCategory(CategoryModel category) async {
    await _firestore.collection('categories').doc(category.id).set(category.toMap());
  }

  //Fetch Categories
  Stream<List<CategoryModel>> getCategories() {
    return _firestore.collection('categories').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => CategoryModel.fromMap(doc.data(), doc.id))
          .toList();
    });
  }

  //Update Category
  Future<void> updateCategory(CategoryModel category) async {
    await _firestore.collection('categories').doc(category.id).update(category.toMap());
  }


  //Delete Category
  Future<void> deleteCategory(String id) async {
    await _firestore.collection('categories').doc(id).delete();
  }
}
