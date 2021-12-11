
class Product {
   final int id;
   final String title;
    var price;
   final String image;

  Product( {
    required this.id,
    required this.price,
    required this.title,
    required this.image,

});
   factory Product.fromjson(Map<String,dynamic> json) {
     return Product(
         id: json['id'],
         title: json['title'],
         image:json['image'],
         price: json['price']
        );
   }
 }