import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class FirestoreUserService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // CREATE or UPDATE User
  Future<void> setUser(UserModel user) async {
    await _db.collection('Users').doc(user.id).set(user.toMap());
  }

  // READ all users
  Stream<List<UserModel>> getUsers() {
    return _db
        .collection('Users')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => UserModel.fromMap(doc.data(), doc.id))
              .toList(),
        );
  }

  // READ single user
  Future<UserModel?> getUser(String id) async {
    var doc = await _db.collection('Users').doc(id).get();
    if (doc.exists) {
      return UserModel.fromMap(doc.data()!, doc.id);
    }
    return null;
  }

  // DELETE user
  Future<void> deleteUser(String id) async {
    await _db.collection('Users').doc(id).delete();
  }
}
