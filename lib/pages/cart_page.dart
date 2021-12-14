import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttercart_sample/databasehandler/dbhelper.dart';
import 'package:fluttercart_sample/model/cart_model.dart';
import 'package:fluttercart_sample/pages/payment_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

var dbHelper = DbHelper();

class _CartPageState extends State<CartPage> {
  late List<CartModel> listOfCartProduct = [];

  @override
  void initState() {
    fetchProduct();
    super.initState();
  }

  double totalPrice = 0;

  fetchProduct() async {
    totalPrice = 0;
    listOfCartProduct = await dbHelper.getAllProducts();
    for (var item in listOfCartProduct) {
      totalPrice = totalPrice + (item.price * item.quantity);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('CART'),
        ),
        body: ListView.builder(
            itemCount: listOfCartProduct.length,
            itemBuilder: (context, index) {
              return SizedBox(
                height: 200,
                width: double.infinity,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
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
                        child: Image.network(
                          listOfCartProduct[index].image,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(listOfCartProduct[index].title,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                            overflow: TextOverflow.ellipsis),
                        Text(
                          '\$ ${listOfCartProduct[index].price * listOfCartProduct[index].quantity}'
                              .toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(
                          'quantity: ${listOfCartProduct[index].quantity}'
                              .toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () async {
                                listOfCartProduct[index].quantity += 1;
                                await dbHelper
                                    .updateProduct(listOfCartProduct[index]);
                                fetchProduct();
                              },
                              icon: const Icon(Icons.add),
                              color: Colors.blue,
                            ),
                            IconButton(
                              disabledColor: Colors.grey,
                              onPressed: listOfCartProduct[index].quantity == 1
                                  ? null
                                  : () async {
                                      listOfCartProduct[index].quantity -= 1;
                                      listOfCartProduct[index].price *
                                          listOfCartProduct[index].quantity;
                                      await dbHelper.updateProduct(
                                          listOfCartProduct[index]);
                                      fetchProduct();
                                    },
                              icon: const Icon(Icons.remove),
                              color: Colors.blue,
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    dbHelper.deleteProduct(
                                        listOfCartProduct[index].id);
                                    fetchProduct();
                                  });
                                },
                                icon: const Icon(Icons.delete),
                                color: Colors.red[400]),
                          ],
                        ),
                        const Divider(
                          height: 2.0,
                          thickness: 1.5,
                        ),
                      ],
                    ),
                  ),
                ]),
              );
            }),
        bottomNavigationBar: Container(
          height: 100,
          color: Colors.white70,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                (const Text(
                  'TOTAL :',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                )),
                Text(
                  '\$ ${totalPrice.toInt()}',
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                FlatButton(
                  onPressed: () {
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Payment_Page()));
                    });
                  },
                  child: const Text(
                    'Checkout',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.blue,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
