class CoinsPack {
  final num price;
  final String tag;
  final int quantity;

  const CoinsPack({
    required this.tag,
    required this.price,
    required this.quantity,
  });

  factory CoinsPack.fromJson(Map<String, dynamic> json) {
    return CoinsPack(
      tag: json['tag'],
      price: json['price'],
      quantity: json['quantity'],
    );
  }

  static List<CoinsPack> pack = [
    CoinsPack(tag: 'Save 20%', price: 2.59, quantity: 450),
    CoinsPack(tag: 'Save 20%', price: 2.59, quantity: 450),
    CoinsPack(tag: 'Save 20%', price: 2.59, quantity: 450),
    CoinsPack(tag: 'Save 20%', price: 2.59, quantity: 450),
  ];
}
