import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/nest_model.dart';

class FirestoreNestService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // CREATE or UPDATE Nest
  Future<void> setNest(String userId, NestModel nest) async {
    await _db
        .collection('Users')
        .doc(userId)
        .collection('nests')
        .doc(nest.id)
        .set(nest.toMap());
  }

  // READ nests of a user
  Stream<List<NestModel>> getNests(String userId) {
    return _db
        .collection('Users')
        .doc(userId)
        .collection('nests')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => NestModel.fromMap(doc.data(), doc.id))
              .toList(),
        );
  }

  // DELETE a nest
  Future<void> deleteNest(String userId, String nestId) async {
    await _db
        .collection('Users')
        .doc(userId)
        .collection('nests')
        .doc(nestId)
        .delete();
  }
}
