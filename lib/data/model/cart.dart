class CartItem {
  int id;
  int quantity;

  CartItem({required this.id, required this.quantity});


  Map<String, dynamic> toJson() {
    return {'id': id, 'quantity': quantity};
  }


  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(id: json['id'], quantity: json['quantity']);
  }
}
