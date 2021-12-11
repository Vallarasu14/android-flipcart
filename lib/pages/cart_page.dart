import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttercart_sample/databasehandler/dbhandler.dart';
import 'package:fluttercart_sample/model/cart_model.dart';
import 'package:fluttercart_sample/pages/payment_page.dart';
import 'package:fluttercart_sample/pages/shopping.dart';


class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}
var dbHelper = DbHelper();

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: FutureBuilder<List<CartModel>>(
        future: dbHelper.getAllProducts(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            List<CartModel> cartProduct = snapshot.data!;
            return ListView.builder(
              itemCount: cartProduct.length,
                itemBuilder: (context,index){
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
                      child: Image.network(cartProduct[index].image,
                        fit: BoxFit.contain,),
                    ),
                  ),
                ),
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(cartProduct[index].title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16
                              ),),
                              Text('\$ ${cartProduct[index].price.toString()}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16
                                ),),
                              Text('Quantity: ${cartProduct[index].quantity.toString()}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13
                                ),),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                      onPressed: (){
                                        setState(() {

                                        });
                                      },
                                      icon:Icon(Icons.add),
                                    color: Colors.blue,),
                                  IconButton(
                                    onPressed: (){},
                                    icon:Icon(Icons.remove),color: Colors.blue,),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {

                                      });
                                    },
                                    icon: Icon(Icons.delete),color:Colors.red[400]
                                  ),
                                ],
                              ),
                              const Divider(height: 2.0,
                              thickness: 1.5,)
                            ],
                          ),
                        ),
                  ]
                  ),
                );

                });
          }return Center(child:Text('${snapshot.error}'));
      },
      ),
      bottomNavigationBar: GestureDetector(
        onTap: (){
          setState(() {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const Payment_Page()));
          });
        },
        child: Container(
          height: 50,
          color: Colors.blue,
          margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
          child: const Center(child: Text('Proceed To Checkout',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15
          ),)),
        ),
      ),
    ));
  }
}
