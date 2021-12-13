class CartModel {
  late String title;
  late double price;
  late String image;
  late int quantity;
  late int id;



  CartModel(this.title, this.image, this.price, this.quantity,this.id);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'title': title,
      'quantity': quantity,
      'price': price,
      'image': image,
      'id':id

    };
    return map;
  }

  CartModel.fromMap(Map<String, dynamic> map) {
    title = map['title'];
    price = map['price'];
    image = map['image'];
    quantity = map['quantity'];
    id = map['id'];
  }
}
