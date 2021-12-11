import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttercart_sample/databasehandler/dbhandler.dart';
import 'package:fluttercart_sample/model/cart_model.dart';
import 'package:fluttercart_sample/pages/cart_page.dart';
import 'package:fluttercart_sample/model/product_mode.dart';
import 'package:http/http.dart' as http;

Future<List<Product>> fetchProduct() async {
  final response = await http.get(Uri.parse('https://fakestoreapi.com/products'));
  if (response.statusCode == 200) {
    List<dynamic> jsonProduct = json.decode(response.body);
    return jsonProduct.map((e) => Product.fromjson(e)).toList();
  } else {
    throw Exception('Failed to load product');
  }
}

class Shopping extends StatefulWidget {
  const Shopping({Key? key}) : super(key: key);

  @override
  _ShoppingState createState() => _ShoppingState();
}

class _ShoppingState extends State<Shopping> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
     fetchProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            elevation: 0.0,
            actions:  [
              IconButton(icon:Icon(Icons.shopping_cart),
              onPressed: (){
                setState(() {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const CartPage()));
                });
              }),
              const SizedBox(
                width: 20,
              ),
              Icon(Icons.logout),
              const SizedBox(
                width: 15,
              ),
            ],
            title: const Text('Home'),
          ),
          drawer: Drawer(
            child: Column(
              children: const [
                UserAccountsDrawerHeader(
                  currentAccountPicture: Center(
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey,
                    ),
                  ),
                  accountName: Text('vallarasu'),
                  accountEmail: Text('vallarasug527@gmail.com'),
                ),
                ListTile(
                  leading: Icon(Icons.favorite),
                  title: Text('My wishlist'),
                ),
                ListTile(
                  leading: Icon(Icons.shopping_cart),
                  title: Text('My cart'),
                ),
                ListTile(
                  leading: Icon(Icons.message),
                  title: Text('My chats'),
                ),
                ListTile(
                  leading: Icon(Icons.shopping_bag),
                  title: Text('My orders'),
                ),
                ListTile(
                  leading: Icon(Icons.card_giftcard),
                  title: Text('My rewards'),
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                ),
                ListTile(
                  leading: Icon(Icons.contact_support),
                  title: Text('About'),
                ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder<List<Product>>(
              future: fetchProduct(),
              builder: (context,snapshot){
                if(snapshot.hasData){
                  final product = snapshot.data;
                  return ListView.builder(
                    itemCount: product!.length,
                      itemBuilder: (context,index) {
                    return Container(
                      height: 200,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Card(
                              elevation: 2.0,
                              clipBehavior: Clip.antiAlias,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: Image.network(product[index].image,
                                fit: BoxFit.contain,),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('${product[index].title}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                                ),
                                overflow: TextOverflow.ellipsis,),
                                Text('\$ ${product[index].price.toString()}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600
                                ),),
                                FlatButton(
                                  onPressed: () {
                                    setState(() {
                                      var dbHelper = DbHelper();
                                      CartModel cModel = CartModel(product[index].title,product[index].image,product[index].price,1);
                                      dbHelper.addToCart(cModel);
                                      final snackBar = SnackBar(
                                        content: Text(product[index].title),
                                        duration: const Duration(seconds: 3),
                                        action: SnackBarAction(
                                          label: 'ok', onPressed: () {  },
                                        ),
                                      );
                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    });
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child:const Text('ADD TO CART',style: TextStyle(
                                    color: Colors.white
                                  ),),
                                  color: Colors.blue,
                                )
                              ],
                            ),
                          ),

                        ],
                    ),
                    );
                  });
                }
                else{
                  return const Center(child: CircularProgressIndicator()
                 );
                }
            },
            ),
          )
    ));
  }
}
