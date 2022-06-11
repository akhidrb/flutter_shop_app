import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy_shop_app/providers/cart.dart';
import 'package:udemy_shop_app/providers/orders.dart';
import 'package:udemy_shop_app/providers/products.dart';
import 'package:udemy_shop_app/screens/cart_screen.dart';
import 'package:udemy_shop_app/screens/edit_product_screen.dart';
import 'package:udemy_shop_app/screens/orders_screen.dart';
import 'package:udemy_shop_app/screens/product_detail_screen.dart';
import 'package:udemy_shop_app/screens/products_overview_screen.dart';
import 'package:udemy_shop_app/screens/user_products_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        ),
      ],
      child: MaterialApp(
        title: "My Shop",
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: "Lato",
        ),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrdersScreen.routeName: (crx) => OrdersScreen(),
          UserProductsScreen.routeName: (crx) => UserProductsScreen(),
          EditProductScreen.routeName: (crx) => EditProductScreen(),
        },
      ),
    );
  }
}
