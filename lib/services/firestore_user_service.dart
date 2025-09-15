import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class FirestoreUserService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // firestore_user_service.dart
  Stream<UserModel?> streamUser(String id) {
    return _db.collection('users').doc(id).snapshots().map((doc) {
      if (doc.exists) {
        return UserModel.fromMap(doc.data()!, doc.id);
      }
      return null;
    });
  }

  // CREATE or UPDATE User
  Future<void> setUser(UserModel user) async {
    await _db.collection('users').doc(user.id).set(user.toMap());
  }

  // READ all users
  Stream<List<UserModel>> getUsers() {
    return _db
        .collection('users')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => UserModel.fromMap(doc.data(), doc.id))
              .toList(),
        );
  }

  // READ single user
  Future<UserModel?> getUser(String id) async {
    var doc = await _db.collection('users').doc(id).get();
    if (doc.exists) {
      return UserModel.fromMap(doc.data()!, doc.id);
    }
    return null;
  }

  // DELETE user
  Future<void> deleteUser(String id) async {
    await _db.collection('users').doc(id).delete();
  }
}
