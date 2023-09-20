
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:plantbackend/screens/Home.dart';
import 'package:plantbackend/screens/Products.dart';
import 'package:plantbackend/screens/bottomnavigate.dart';
import 'package:plantbackend/screens/cart.dart';
import 'package:plantbackend/screens/checkout.dart';
import 'package:plantbackend/screens/descpage.dart';
import 'package:plantbackend/screens/fertilizers.dart';
import 'package:plantbackend/screens/payment.dart';
import 'package:plantbackend/screens/plants.dart';
import 'package:plantbackend/screens/productDesc.dart';
import 'package:plantbackend/screens/soil.dart';
import 'package:plantbackend/screens/tabView.dart';
import 'package:plantbackend/screens/tools.dart';
import 'package:plantbackend/screens/wishlist.dart';
import 'package:plantbackend/screens/zodiac.dart';

import 'graphql_client.dart';

void main() {
  runApp(GraphQLProvider(
      client: client,
      child: CacheProvider(
      child: MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'bottomnavigation',
    routes: {
      'Home':(context)=>HomePage(),
      'bottomnavigation':(context)=>BottomNavigation(),
      '/plants':(context)=>Plants(),
      '/fertilizers':(context)=>Fertilizers(plantId: ""),
      '/soil':(context)=>Soil(category: "All",client:GraphQLClient(link: httpLink,cache: GraphQLCache())),
      //'/tools':(context)=>Tools(),
      'descpage':(context)=>DescPage(),
      'wishlist':(context)=>WishList(),
      'tabview':(context)=>TabView(),
      'zodiac':(context)=>Zodiac(),
      'cart':(context)=>ShoppingCart(),
      'checkout':(context)=>Checkout(),
      'payment':(context)=>Payment(),
      'products':(context)=>Products(mainCategory: "",client:GraphQLClient(link: httpLink,cache: GraphQLCache())),
      'productDesc':(context)=>ProductDesc(productId: "")


    },
  ))));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


