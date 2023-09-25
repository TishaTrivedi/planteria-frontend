import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:plantbackend/screens/Home.dart';
import 'package:plantbackend/screens/Products.dart';
import 'package:plantbackend/screens/cart.dart';
import 'package:plantbackend/screens/costumanimatedbottom.dart';
import 'package:plantbackend/screens/fertilizers.dart';
import 'package:plantbackend/screens/payment.dart';
import 'package:plantbackend/screens/plants.dart';
import 'package:plantbackend/screens/profile.dart';
import 'package:plantbackend/screens/soil.dart';
import 'package:plantbackend/screens/tools.dart';
import 'package:plantbackend/screens/wishlist.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;

  final _inactiveColor = Colors.grey;

  final List<Widget> pages = [
    HomePage(),
    Plants(),

    // Fertilizers(),
    // Soil(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawerEnableOpenDragGesture: true,
        body: getBody(),
        bottomNavigationBar: _buildBottomBar());
  }

  Widget _buildBottomBar() {
    return WillPopScope(
      onWillPop: () async {
        // Check if we're on the home page, if not, navigate back
        if (_currentIndex != 0) {
          setState(() {
            _currentIndex = 0;
          });
          return false; // Prevent exiting the app
        }
        return true; // Allow exiting the app
      },
      child: Container(
        color: Colors.lightGreen[50],
        height: 73,
        padding: EdgeInsets.all(10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(60),
          child: CurvedNavigationBar(
              height: 50,
              backgroundColor: Color(0xFF3C593B),
              color: Color(0xFF2F482D),
              //buttonBackgroundColor: Colors.black12,
              onTap: (index) => setState(() => _currentIndex = index),
              //selectedIndex: _currentIndex,
              items: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Icon(Icons.home, color: Colors.white, size: 25),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Icon(Icons.favorite_border_outlined,
                      color: Colors.white, size: 25),
                ),
                Align(
                  alignment: Alignment.center,
                  child:
                      Icon(Icons.shopping_cart, color: Colors.white, size: 25),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Icon(Icons.person, color: Colors.white, size: 25),
                ),
              ]),
        ),
      ),
    );
  }

  Widget getBody() {
    List<Widget> pages = [
      // MaterialApp(
      //   home: HomePage(),
      //   debugShowCheckedModeBanner: false,
      //   onGenerateRoute: (settings) {
      //     Widget page = Container();
      //
      //     if (settings.name == '/plants') {
      //       page = Plants();
      //     } else if (settings.name == '/tools') {
      //       page = Tools();
      //
      //     }
      //     else if(settings.name =='/wishlist')
      //
      //     return MaterialPageRoute(builder: (_) => page);
      //   },
      // ),
      HomePage(),
      WishList(),
      ShoppingCart(quant: 1),
      Profile(),
      //Products(),

      //child:Navigator.pushNamed(context,MaterialPageRoute(builder: (context)=>FavoritesPage(favorites: List.empty())));
    ];
    return IndexedStack(
      index: _currentIndex,
      children: pages,
    );
  }
}
