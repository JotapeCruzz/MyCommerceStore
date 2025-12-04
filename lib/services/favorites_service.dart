import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoritesService {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  String get _uid {
    final user = _auth.currentUser;
    if (user == null) throw Exception('Usuário não logado');
    return user.uid;
  }

  CollectionReference get _col =>
      _firestore.collection('users').doc(_uid).collection('favorites');

  Future<void> addFavorite(String productId) async {
    await _col.doc(productId).set({
      'productId': productId,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> removeFavorite(String productId) async {
    await _col.doc(productId).delete();
  }

  Stream<List<String>> favoritesStream() {
    return _col.snapshots().map(
          (snap) => snap.docs.map((d) => d.id).toList(),
        );
  }
}
