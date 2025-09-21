import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/bank_account_model.dart';

class FirestoreBankAccountService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // CREATE or UPDATE bank account
  Future<void> setBankAccount(String userId, BankAccountModel bank) async {
    await _db
        .collection('users')
        .doc(userId)
        .collection('bank_accounts')
        .doc(bank.id)
        .set(bank.toMap());
  }

  // READ bank accounts for a user
  Stream<List<BankAccountModel>> getBankAccounts(String userId) {
    return _db
        .collection('users')
        .doc(userId)
        .collection('bank_accounts')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => BankAccountModel.fromMap(doc.data(), doc.id))
              .toList(),
        );
  }

  // DELETE bank account
  Future<void> deleteBankAccount(String userId, String bankId) async {
    await _db
        .collection('users')
        .doc(userId)
        .collection('bank_accounts')
        .doc(bankId)
        .delete();
  }
}
