import 'contact.dart';

class Transaction {
  String? id;
  late double value;
  Contact? contact;
  String? dateTime;

  Transaction({this.id, required this.value, this.contact, this.dateTime}) : assert(value > 0);

  Transaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
    contact = json['contact'] != null ? Contact.fromJson(json['contact']) : null;
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['value'] = value;
    if (contact != null) {
      data['contact'] = contact!.toJson();
    }
    data['dateTime'] = dateTime;
    return data;
  }
}
