
import 'dart:async';


import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:plantbackend/screens/Home.dart';
import 'package:plantbackend/screens/Products.dart';
import 'package:plantbackend/screens/address.dart';
import 'package:plantbackend/screens/bottomnavigate.dart';
import 'package:plantbackend/screens/cart.dart';
import 'package:plantbackend/screens/checkout.dart';
import 'package:plantbackend/screens/confirmOrder.dart';
import 'package:plantbackend/screens/descpage.dart';
import 'package:plantbackend/screens/fertilizers.dart';
import 'package:plantbackend/screens/login.dart';
import 'package:plantbackend/screens/payment.dart';
import 'package:plantbackend/screens/plants.dart';
import 'package:plantbackend/screens/productDesc.dart';
import 'package:plantbackend/screens/profile.dart';
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
    initialRoute: 'splash',
    routes: {
      'splash':(context)=>SplashScreen(),
      'login':(context)=>Login(),
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
      'cart':(context)=>ShoppingCart(quant: 1),
      'checkout':(context)=>Checkout(totalBagTotal: 0,totalItemTotal: 0,totalShippingCost: 0),
      'payment':(context)=>Payment(totalShippingCost: 0,totalItemTotal: 0,totalBagTotal: 0),
      'products':(context)=>Products(mainCategory: "",client:GraphQLClient(link: httpLink,cache: GraphQLCache())),
      'productDesc':(context)=>ProductDesc(productId: ""),
      'confirm':(context)=>ConfirmOrder(),
      'profile':(context)=>Profile(),
      'address':(context)=>Address(),


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
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Replace the route name with the desired initial route after the splash screen
    Timer(
      Duration(seconds: 3),
          () => Navigator.pushReplacementNamed(context, 'login'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen.shade50, // Set the background color of the Scaffold
      body: Center(
        child: Container(
          // You can remove the background color from this Container
          child: Image.asset(
            "assets/splash/splashLogo2.png",
            height: 650,
            width: 400,
          ),
        ),
      ),
    );
  }
}

