import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/transfer_model.dart';

class FirestoreTransferService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // CREATE or UPDATE Transfer
  Future<void> setTransfer(String userId, TransferModel transfer) async {
    await _db
        .collection('Users')
        .doc(userId)
        .collection('transfers')
        .doc(transfer.id)
        .set(transfer.toMap());
  }

  // READ transfers of a user
  Stream<List<TransferModel>> getTransfers(String userId) {
    return _db
        .collection('Users')
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
        .collection('Users')
        .doc(userId)
        .collection('transfers')
        .doc(transferId)
        .delete();
  }
}
