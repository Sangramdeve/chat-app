import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addDocuments({
    required String collectionPath,
    required String document,
    required Map<String, dynamic> data,
  }) async {
    try {
      await _firestore.collection(collectionPath).doc(document).set(data);
    } catch (e) {
      rethrow;
    }
  }

  Future<DocumentSnapshot> getDocument({
    required String collectionPath,
    required String userId,
  }) async {
    try {
      final response = _firestore.collection(collectionPath).doc(userId).get();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateDocument(
      {required String collectionPath,
      required String document,
      required Map<String, dynamic> data}) async {
    try {
      await _firestore.collection(collectionPath).doc(document).update(data);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteDocument({
    required String collectionPath,
    required String userId,
  }) async {
    try {
      _firestore.collection(collectionPath).doc(userId).delete();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<DocumentSnapshot>> querySnapshot(
      {required String collectionPath,
      required String param,
      required String value}) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection(collectionPath)
          .where(param, isEqualTo: value)
          .get();
      return querySnapshot.docs;
    } catch (e) {
      rethrow;
    }
  }
}
