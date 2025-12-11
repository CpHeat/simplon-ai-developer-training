class Balance {
  final value;

  Balance(this.value);

  Balance.fromJson(Map<String, dynamic> json) : value = json['value'];
}
