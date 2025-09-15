import 'package:cloud_firestore/cloud_firestore.dart';

class TransferModel {
  final String id;
  final DateTime datetime;
  final String transferType;

  TransferModel({
    required this.id,
    required this.datetime,
    required this.transferType,
  });

  factory TransferModel.fromMap(Map<String, dynamic> data, String id) {
    return TransferModel(
      id: id,
      datetime: (data['datetime'] as Timestamp).toDate(),
      transferType: data['transfer_type'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {'datetime': datetime, 'transfer_type': transferType};
  }
}
