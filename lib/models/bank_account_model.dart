class BankAccountModel {
  final String id;
  final String accName;

  BankAccountModel({required this.id, required this.accName});

  factory BankAccountModel.fromMap(Map<String, dynamic> data, String id) {
    return BankAccountModel(id: id, accName: data['acc_name'] ?? '');
  }

  Map<String, dynamic> toMap() {
    return {'acc_name': accName};
  }
}
