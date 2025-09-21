import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/nest_model.dart';

class FirestoreNestService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // helper to get the subcollection reference
  CollectionReference<Map<String, dynamic>> nestsRef(String userId) {
    return _db
        .collection('users')
        .doc(userId)
        .collection('nests')
        .withConverter<Map<String, dynamic>>(
          fromFirestore: (snap, _) => snap.data() ?? <String, dynamic>{},
          toFirestore: (map, _) => map,
        );
  }

  /// CREATE/UPDATE using provided nest.id
  Future<void> setNest(String userId, NestModel nest) async {
    await nestsRef(userId).doc(nest.id).set(nest.toMap());
  }

  /// CREATE with an auto-generated id. Returns the generated id.
  Future<String> addNest(String userId, NestModel nest) async {
    final docRef = nestsRef(userId).doc(); // auto id
    await docRef.set(nest.toMap());
    return docRef.id;
  }

  Future<List<NestModel>> refreshNests(String userId) async {
    final snapshot = await _db
        .collection('users')
        .doc(userId)
        .collection('nests')
        .get(const GetOptions(source: Source.server));
    return snapshot.docs
        .map((doc) => NestModel.fromMap(doc.data(), doc.id))
        .toList();
  }

  /// READ: stream of nests for a user
  Stream<List<NestModel>> getNests(String userId) {
    return _db
        .collection('users')
        .doc(userId)
        .collection('nests')
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => NestModel.fromMap(doc.data(), doc.id))
              .toList();
        });
  }

  /// READ once (single document)
  Future<NestModel?> getNestOnce(String userId, String nestId) async {
    final doc = await nestsRef(userId).doc(nestId).get();
    if (!doc.exists) return null;
    final data = doc.data() as Map<String, dynamic>;
    return NestModel.fromMap(data, doc.id);
  }

  /// UPDATE fields
  Future<void> updateNest(
    String userId,
    String nestId,
    Map<String, dynamic> updates,
  ) async {
    await nestsRef(userId).doc(nestId).update(updates);
  }

  /// DELETE
  Future<void> deleteNest(String userId, String nestId) async {
    await nestsRef(userId).doc(nestId).delete();
  }

  Future<void> updateNestAmount({
    required String nestName,
    required double addedAmount,
  }) async {
    final nestsRef = FirebaseFirestore.instance
        .collection('users')
        .doc('001') // Replace with actual userId
        .collection('nests');

    final query = await nestsRef.where('name', isEqualTo: nestName).get();

    if (query.docs.isNotEmpty) {
      final doc = query.docs.first;
      final currentAmount = (doc['current_amount'] ?? 0).toDouble();
      await doc.reference.update({
        'current_amount': currentAmount + addedAmount,
      });
    }
  }
}
