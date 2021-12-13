import 'dart:async';
import 'dart:async';
import 'dart:io' as io;
import 'package:fluttercart_sample/model/cart_model.dart';
import 'package:fluttercart_sample/model/user_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  Database? _db;

  static const String DB_Name = 'test.db';
  static const String Table_User = 'user';
  static const int Version = 1;

  static const String C_UserID = 'userid';
  static const String C_UserName = 'username';
  static const String C_Email = 'email';
  static const String C_Password = 'password';

  static const String Table_Cart = 'Cart';
  static const String C_ID = 'id';
  static const String C_Title = 'title';
  static const String C_Price = 'price';
  static const String C_Image = 'image';
  static const String C_Quantity = 'quantity';

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_Name);
    var db = await openDatabase(path, version: Version, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int intVersion) async {
    await db.execute("CREATE TABLE $Table_User ("
        " $C_UserID  INTEGER PRIMARY KEY AUTOINCREMENT,"
        " $C_UserName TEXT, "
        " $C_Email TEXT,"
        " $C_Password TEXT"
        ")");

    await db.execute("CREATE TABLE $Table_Cart ("
        "$C_ID INTEGER PRIMARY KEY AUTOINCREMENT,"
        " $C_Title TEXT,"
        "$C_Price REAL,"
        "$C_Image TEXT,"
        "$C_Quantity INT"
        ")");
  }

  Future<int> saveData(UserModel user) async {
    var dbClient = await db;
    var result = await dbClient.insert(Table_User, user.toMap());
    print(result);
    return result;
  }

  Future<UserModel?> getLoginUser(String email, String password) async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $Table_User WHERE "
        "$C_Email = '$email' AND "
        "$C_Password = '$password'");

    if (result.isNotEmpty) {
      return UserModel.fromMap(result.first);
    }

    return null;
  }

// function for saving products in cart

  Future<int> addToCart(CartModel cart) async {
    var dbClient = await db;
    var result = await dbClient.insert(Table_Cart, cart.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print(result);
    return result;
  }

  // retrieve cartProducts
  Future<List<CartModel>> getAllProducts() async {
    var dbClient = await db;
    List<Map<String, dynamic>> maps = await dbClient.query(Table_Cart);

    // Convert the List<Map<String, dynamic> into a List<CartModel>.
    return List.generate(maps.length, (i) {
      return CartModel(
        maps[i]['title'],
        maps[i]['image'],
        maps[i]['price'],
        maps[i]['quantity'],
        maps[i]['id']
      );
    });
  }

  Future<dynamic> deleteProduct(int id) async {
    var dbClient = await db;
     var result = await dbClient.delete('Table_Cart',where: 'id =?',whereArgs: [id]);
    return result;
  }

  Future<void> updateProduct(CartModel cart) async {
    var dbClient = await db;
    var result = await dbClient.update('Table_Cart',cart.toMap(),where: 'id =?',whereArgs: [cart.id]);
  }
}
