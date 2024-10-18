class LaporanBulanan {
  int? id;
  String? month;
  int? income;
  int? expenses;

  LaporanBulanan({this.id, this.month, this.income, this.expenses});

  factory LaporanBulanan.fromJson(Map<String, dynamic> obj) {
    return LaporanBulanan(
      id: obj['id'],
      month: obj['month'],
      income: obj['income'],
      expenses: obj['expenses'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'month': month,
      'income': income,
      'expenses': expenses,
    };
  }
}
