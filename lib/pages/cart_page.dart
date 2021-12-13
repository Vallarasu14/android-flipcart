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
  int value = 1;
  double payableAmount=1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: const Text('CART'),
      ),
      body: Container(
        child: FutureBuilder<List<CartModel>>(
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
                                ),
                                overflow: TextOverflow.ellipsis),
                                Text('\$ ${cartProduct[index].price}'.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16
                                  ),),
                                Text(value.toString(),
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
                                            value ++;
                                          });
                                        },
                                        icon:const Icon(Icons.add),
                                      color: Colors.blue,),
                                    IconButton(
                                      disabledColor: Colors.grey,
                                     onPressed: value==1? null: ()=> setState(() {
                                       value--;
                                     }),
                                      icon:const Icon(Icons.remove),color: Colors.blue,),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          dbHelper.deleteProduct(cartProduct[index].id);
                                        });
                                      },
                                      icon: const Icon(Icons.delete),color:Colors.red[400]
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
      ),
      bottomNavigationBar:
         Container(
          height: 100,
          color: Colors.white70,
          margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
          child:Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ( const Text('TOTAL :',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold
                ),)),
                const Text('\$50.14',style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                    fontWeight: FontWeight.bold
                ),),
                FlatButton(onPressed: () {
                  setState(() {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const Payment_Page()));
                  });
                },
                  child: const Text('Checkout',style: TextStyle(color: Colors.white),),
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
