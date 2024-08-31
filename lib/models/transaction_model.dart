class Transaction
{
  final int? id;
  final String?  category;
  final String? type;
  final double? amount;
  final String? note;
  final String? description;
  final DateTime? transactionDate;
  final String? imagePath;

  Transaction({this.id,this.category,this.type,this.amount,this.note,this.description,this.transactionDate,this.imagePath});
  factory Transaction.fromMap(Map data)
  {
    return Transaction(
      id: data['id'],
      category: data['category'],
      type: data['type'],
      amount: data['amount'],
      description: data['description'],
      note: data['note'],
      transactionDate: DateTime.parse(data['transactionDate']),
      imagePath: data['imagePath'],
    );
  }

}