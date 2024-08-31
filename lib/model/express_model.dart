class ExpenseModel {
  String? id;
  String? name;
  int? amount;
  String? date;
  String? invoice;
  String? createdAt;
  String? updatedAt;
  int? v;

  ExpenseModel(
      {
      required this.id,
      this.name,
      this.amount,
      this.date,
      this.invoice,
      this.createdAt,
      this.updatedAt,
      this.v});

  ExpenseModel.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    name = json["name"];
    amount = json["amount"];
    date = json["date"];
    invoice = json["invoice"];
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
    v = json["__v"];
  }
 // createdAt : DateTime.tryParse(json["createdAt"] ?? ""),
 // updatedAt : DateTime.tryParse(json["updatedAt"] ?? ""),
 // date : DateTime.tryParse(json["date"] ?? ""),
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    data["name"] = name;
    data["amount"] = amount;
    data["date"] = date;
    data["invoice"] = invoice;
    data["createdAt"] = createdAt;
    data["updatedAt"] = updatedAt;
    data["__v"] = v;
    return data;
  }
}
