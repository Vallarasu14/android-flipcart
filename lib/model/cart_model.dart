class CartModel {

  late String title;
  late double price;
  late String image;
  late int quantity;


  CartModel(this.title, this.image, this.price, this.quantity);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'title': title,
      'quantity': quantity,
      'price': price,
      'image': image
    };
    return map;
  }

  CartModel.fromMap(Map<String, dynamic> map) {
    title = map['title'];
    price = map['price'];
    image = map['image'];
    quantity = map['quantity'];
  }
}
