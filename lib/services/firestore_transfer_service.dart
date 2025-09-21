import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/transfer_model.dart';

class FirestoreTransferService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // CREATE or UPDATE Transfer
  Future<void> setTransfer(String userId, TransferModel transfer) async {
    await _db
        .collection('users')
        .doc(userId)
        .collection('transfers')
        .doc(transfer.id)
        .set(transfer.toMap());
  }

  // READ transfers of a user
  Stream<List<TransferModel>> getTransfers(String userId) {
    return _db
        .collection('users')
        .doc(userId)
        .collection('transfers')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => TransferModel.fromMap(doc.data(), doc.id))
              .toList(),
        );
  }

  // DELETE a transfer
  Future<void> deleteTransfer(String userId, String transferId) async {
    await _db
        .collection('users')
        .doc(userId)
        .collection('transfers')
        .doc(transferId)
        .delete();
  }

  /// returns true if there was at least one transfer in the last 24 hours
  Future<bool> hasTransferredInLast24Hours(String userId) async {
    final now = DateTime.now();
    final since = now.subtract(const Duration(hours: 24));
    final snapshot = await _db
        .collection('users')
        .doc(userId)
        .collection('transfers')
        .where('datetime', isGreaterThan: Timestamp.fromDate(since))
        .limit(1)
        .get();

    return snapshot.docs.isNotEmpty;
  }
}
