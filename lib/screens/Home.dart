import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql/client.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:like_button/like_button.dart';
import 'package:plantbackend/screens/Products.dart';
import 'package:plantbackend/screens/productDesc.dart';
import 'package:plantbackend/screens/soil.dart';
import 'package:plantbackend/screens/tabView.dart';

import '../graphql_client.dart';
import 'fertilizers.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late GraphQLClient client;

  final List<PlantsData> plantList = [
    PlantsData(
        plantImage: "assets/sample/i1.png",
        plantName: "Money Plant",
        plantCategory: "Indoor",
        plantPrice: "149"),
    PlantsData(
        plantImage: "assets/sample/i2.png",
        plantName: "Money Plant",
        plantCategory: "Indoor",
        plantPrice: "49"),
    PlantsData(
        plantImage: "assets/sample/i3.png",
        plantName: "Money Plant",
        plantCategory: "Indoor",
        plantPrice: "249"),
    PlantsData(
        plantImage: "assets/sample/i12.png",
        plantName: "Money Plant",
        plantCategory: "Indoor",
        plantPrice: "349"),
    PlantsData(
        plantImage: "assets/sample/i5.png",
        plantName: "Money Plant",
        plantCategory: "Indoor",
        plantPrice: "99"),
    PlantsData(
        plantImage: "assets/sample/i6.png",
        plantName: "Money Plant",
        plantCategory: "Indoor",
        plantPrice: "199"),
    PlantsData(
        plantImage: "assets/sample/i7.png",
        plantName: "Money Plant",
        plantCategory: "Indoor",
        plantPrice: "299"),
    PlantsData(
        plantImage: "assets/sample/i8.png",
        plantName: "Money Plant",
        plantCategory: "Indoor",
        plantPrice: "79"),
    PlantsData(
        plantImage: "assets/sample/i9.png",
        plantName: "Money Plant",
        plantCategory: "Indoor",
        plantPrice: "179"),
    PlantsData(
        plantImage: "assets/sample/i10.png",
        plantName: "Money Plant",
        plantCategory: "Indoor",
        plantPrice: "279"),
  ];

  final List<CategoryData> categoryList = [
    CategoryData(
        categoryImage: "assets/category/plantsc.png", categoryName: "Plants"),
    CategoryData(
        categoryImage: "assets/category/toolsc.png", categoryName: "Tools"),
    CategoryData(
        categoryImage: "assets/category/pot3.png", categoryName: "Pots"),
    CategoryData(
        categoryImage: "assets/category/f1.png", categoryName: "Fertilizers"),
  ];

  final int _numPages = onboardingPages.length;
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;
  final Duration _duration = Duration(seconds: 5);

  @override
  void initState() {
    super.initState();
    client = GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(),
    );
    _timer = Timer.periodic(_duration, (Timer timer) {
      if (_currentPage < _numPages - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 100),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  bool isLiked = false;
  void _toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[50],
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 40, left: 10),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Welcome",
                    style: GoogleFonts.playfairDisplay(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 45, left: 5),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Tisha,",
                    style: GoogleFonts.playfairDisplay(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(top: 45, left: 140),
                    alignment: Alignment.topLeft,
                    child: CircleAvatar(
                      backgroundImage: AssetImage("assets/tisha.jpg"),
                      radius: 25,
                    )),
              ],
            ),
            Container(
              height: 110,
              padding: EdgeInsets.only(left: 10, right: 10, top: 20),
              child: TextField(
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                    fillColor: Colors.white54.withOpacity(0.5),
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide:
                            BorderSide(color: Colors.teal.shade700, width: 2)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal.shade900),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.teal.shade700,
                    )),
              ),
            ),
            // SizedBox(
            //   height: 20,
            // ),
            Container(
              height: 200,
              child: PageView.builder(
                controller: _pageController,
                itemCount: _numPages,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            16), // Adjust the corner radius as needed
                      ),
                      elevation: 3, // Adjust the elevation as needed
                      child: Container(
                        width: double.infinity,
                        // padding: EdgeInsets.all(10),
                        child: onboardingPages[
                            index], // Your content for each onboarding page
                      ),
                    ),
                  );
                },
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
              ),
            ),
            Container(
              height: 140,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoryList.length,
                itemBuilder: (context, index) {
                  return Container(
                      width: 95, // Adjust the width of each item as needed
                      margin: EdgeInsets.symmetric(horizontal: 0),
                      child: GestureDetector(
                        onTap: () {
                          switch (index) {
                            case 0:
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TabView()));
                              break;
                            case 1:
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Products(
                                            mainCategory: "tool",
                                            client: GraphQLClient(
                                                link: httpLink,
                                                cache: GraphQLCache()),
                                          )));
                              break;
                            case 2:
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Products(
                                            mainCategory: "pot",
                                            client: GraphQLClient(
                                                link: httpLink,
                                                cache: GraphQLCache()),
                                          )));
                              break;
                            case 3:
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Products(
                                            mainCategory: "fertilizer",
                                            client: GraphQLClient(
                                                link: httpLink,
                                                cache: GraphQLCache()),
                                          )));
                              break;
                          }
                        },
                        child: Column(
                          children: [
                            Positioned(
                              left: 10,
                              top: 14,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 70,
                                    top: 80,
                                    child: Transform(
                                      transform: Matrix4.identity()
                                        ..translate(0.0, 0.0)
                                        ..rotateZ(-3.14),
                                      child: Container(
                                        width: 70,
                                        height: 70,
                                        decoration: ShapeDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment(0.00, -1.00),
                                            end: Alignment(0, 1),
                                            colors: [
                                              Color(0xFF21411C),
                                              Color(0xFF50694C),
                                              Color(0xFF99A897),
                                            ],
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(24),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 70,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            categoryList[index].categoryImage),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              left: 25,
                              top: 100,
                              child: Text(
                                categoryList[index].categoryName,
                                style: GoogleFonts.playfairDisplay(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ));
                },
              ),
            ),

            Container(
              padding: EdgeInsets.only(left: 10),
              alignment: Alignment.topLeft,
              child: Text("Recently Viewed",
                  style: GoogleFonts.playfairDisplay(
                    color: Color(0xFF0D0D0D),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.left),
            ),
            Container(
              height: 220,
              child: Query(
                  options: QueryOptions(
                    document: gql('''
                        query{
                        displayUserRecentlyViewed(customerId:1){
                          plantId{
                          id
                            plantName
                            price
                            images
                            category
                          }
                          productId{
                          id
                            productName
                            price
                            images
                            mainCategory
                          }
                       
                        }
                      }
                      '''),
                  ),
                  builder: (QueryResult result, {fetchMore, refetch}) {
                    if (result.hasException) {
                      return Center(
                        child: Text(
                          'Error fetching data: ${result.exception.toString()}',
                        ),
                      );
                    }

                    if (result.isLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final recentlyViewed =
                        result.data?['displayUserRecentlyViewed'] as List;
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: recentlyViewed.length,
                        itemBuilder: (context, index) {
                          final cartItem = recentlyViewed[index];
                          final product = cartItem['productId'];
                          final plant = cartItem['plantId'];
                          //final quantity = cartItem['quantity'];
                          String imageUrl;

                          if (product != null) {
                            imageUrl = "${httpLinkImage}${product['images']}";
                          } else if (plant != null) {
                            imageUrl = "${httpLinkImage}${plant['images']}";
                          } else {
                            // Handle the case where neither product nor plant is available
                            imageUrl = "null";
                          }

                          return GestureDetector(
                            onTap: () {
                              if (plant != null && product == null) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Fertilizers(plantId: plant['id'])));
                              } else if (product != null && plant == null) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProductDesc(
                                            productId: product['id'])));
                              } else {
                                // Handle the case where both plant and product are null or where 'id' is null in both cases
                                // You can show an error message or navigate to a default page
                              }
                            },
                            child: Container(
                              width:
                                  130, // Adjust the width of each item as needed
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 131,
                                    top: 190,
                                    child: Transform(
                                      transform: Matrix4.identity()
                                        ..translate(0.0, 0.0)
                                        ..rotateZ(-3.14),
                                      child: Container(
                                        width: 131,
                                        height: 166,
                                        decoration: ShapeDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment(0.00, -1.00),
                                            end: Alignment(0, 1),
                                            colors: [
                                              Color(0xFF99A897),
                                              Color(0xFF50694C),
                                              Color(0xFF21411C)
                                            ],
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(24),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 12,
                                    top: 98,
                                    child: Container(
                                      width: 105,
                                      height: 48,
                                      child: Text(
                                        product != null
                                            ? product['productName']
                                            : plant['plantName'],
                                        style: GoogleFonts.playfairDisplay(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 85,
                                    top: 145.34,
                                    child: Container(
                                      width: 35,
                                      height: 30.45,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0)),
                                      child: IconButton(
                                        onPressed: () async {
                                          final itemId = product != null
                                              ? product['id']
                                              : plant['id'];
                                          final itemType = product != null
                                              ? 'product'
                                              : 'plant';
                                          final quantity =
                                              1; // You can adjust the quantity as needed

                                          final addToCartMutation = gql('''
      mutation AddToCart(\$customerId: ID!, \$itemId: ID!, \$itemType: String!, \$quantity: Int!) {
        addToCart(customerId: \$customerId, itemId: \$itemId, itemType: \$itemType, quantity: \$quantity) {
          savedProduct {
            id
            # Add other fields you want to retrieve
          }
        }
      }
    ''');

                                          try {
                                            final result = await client.mutate(
                                              MutationOptions(
                                                document: addToCartMutation,
                                                variables: {
                                                  'customerId':
                                                      1, // Replace with the actual customer ID
                                                  'itemId': itemId,
                                                  'itemType': itemType,
                                                  'quantity': quantity,
                                                },
                                              ),
                                            );

                                            if (result.hasException) {
                                              // Handle the error here.
                                              print(
                                                  'Error: ${result.exception.toString()}');
                                              // You can also show an error message to the user.
                                            } else {
                                              // Product/plant added to cart successfully.
                                              // You can update the UI or show a confirmation message.
                                              print('Item added to cart.');

                                              // Show a Snackbar with the success message
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                      'Item added to cart successfully.'),
                                                  duration: Duration(
                                                      seconds:
                                                          2), // You can adjust the duration
                                                ),
                                              );
                                            }
                                          } catch (error) {
                                            // Handle any unexpected errors here.
                                            print('Unexpected error: $error');
                                          }
                                        },
                                        icon: Icon(Icons.shopping_cart),
                                        color: Colors.white
                                            .withOpacity(0.7400000095367432),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 13,
                                    top: 161,
                                    child: Container(
                                      width: 55.23,
                                      height: 18.57,
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            left: 0,
                                            top: 0,
                                            child: Container(
                                              width: 55.23,
                                              height: 18.57,
                                              decoration: ShapeDecoration(
                                                color: Colors.white.withOpacity(
                                                    0.7099999785423279),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(24),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 3,
                                            top: 0,
                                            child: SizedBox(
                                              width: 45,
                                              height: 18,
                                              child: Text(
                                                '₹ ' +
                                                    (product != null
                                                        ? product['price']
                                                            .toString()
                                                        : plant['price']
                                                            .toString()),
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.acme(
                                                  color: Color(0xFF20401B),
                                                  fontSize: 15.50,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 12,
                                    top: 137,
                                    child: SizedBox(
                                      width: 111,
                                      height: 22.51,
                                      child: Text(
                                        product != null
                                            ? product['mainCategory']
                                                .toString()
                                                .toLowerCase()
                                            : plant['category']
                                                .toString()
                                                .toLowerCase(),
                                        style: GoogleFonts.playfairDisplay(
                                          color: Colors.white
                                              .withOpacity(0.7400000095367432),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 13,
                                    top: 40.31,
                                    child: Container(
                                      width: 40,
                                      height: 43.45,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0)),
                                      child: IconButton(
                                          icon: Icon(
                                            isLiked
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: isLiked
                                                ? Colors.red.shade600
                                                : null, // Set the color to red if it's liked
                                          ),
                                          onPressed: _toggleLike,
                                          color: Colors.white),
                                    ),
                                  ),
                                  Positioned(
                                    left: 61,
                                    top: -10,
                                    child: Container(
                                      width: 69,
                                      height: 115,
                                      child: imageUrl != null
                                          ? Image.network(
                                              imageUrl,
                                              width: 38.26,
                                              height: 70.48,
                                              fit: BoxFit.fill,
                                            )
                                          : Image.asset(
                                              "assets/category/f1.png",
                                              width: 28.26,
                                              height: 63.48,
                                              fit: BoxFit.fill,
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  }),
            ),
            //     Container(
            //       padding: EdgeInsets.only(left:10),
            //       alignment: Alignment.topLeft,
            //
            //       child: Text("Trending",
            //           style: GoogleFonts.playfairDisplay(
            //             color: Color(0xFF0D0D0D),
            //             fontSize: 20,
            //
            //             fontWeight: FontWeight.w600,
            //           ),
            //           textAlign: TextAlign.left),
            //
            //
            //     ),
            //     Container(
            //       height: 220,
            //       child: ListView.builder(
            //         scrollDirection: Axis.horizontal,
            //         itemCount: plantList.length,
            //         itemBuilder: (context, index) {
            //           return Container(
            //             width: 130, // Adjust the width of each item as needed
            //             margin: EdgeInsets.symmetric(horizontal: 10),
            //             child: Stack(
            //               children: [
            //                 Positioned(
            //                   left: 131,
            //                   top: 190,
            //                   child: Transform(
            //                     transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(-3.14),
            //                     child: Container(
            //                       width: 131,
            //                       height: 166,
            //                       decoration: ShapeDecoration(
            //                         gradient: LinearGradient(
            //                           begin: Alignment(0.00, -1.00),
            //                           end: Alignment(0, 1),
            //                           colors: [ Color(0xFF99A897),Color(0xFF50694C),Color(0xFF21411C)],
            //                         ),
            //                         shape: RoundedRectangleBorder(
            //                           borderRadius: BorderRadius.circular(24),
            //                         ),
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //                 Positioned(
            //                   left: 12,
            //                   top: 111,
            //                   child: SizedBox(
            //                     width: 147,
            //                     height: 24,
            //                     child: Text(
            //                       plantList[index].plantName,
            //                       style: GoogleFonts.playfairDisplay(
            //                         color: Colors.white,
            //                         fontSize: 18,
            //                         fontWeight: FontWeight.w600,
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //                 Positioned(
            //                   left: 85,
            //                   top: 145.34,
            //                   child: Container(
            //                     width: 35,
            //                     height: 30.45,
            //                     clipBehavior: Clip.antiAlias,
            //                     decoration: BoxDecoration(color: Colors.black.withOpacity(0)),
            //                     child: IconButton(
            //                       onPressed: (){},
            //                       icon: Icon(Icons.shopping_cart),
            //                       color:Colors.white.withOpacity(0.7400000095367432),
            //                     ),
            //                   ),
            //                 ),
            //                 Positioned(
            //                   left: 13,
            //                   top: 161,
            //                   child: Container(
            //                     width: 55.23,
            //                     height: 18.57,
            //                     child: Stack(
            //                       children: [
            //                         Positioned(
            //                           left: 0,
            //                           top: 0,
            //                           child: Container(
            //                             width: 55.23,
            //                             height: 18.57,
            //                             decoration: ShapeDecoration(
            //                               color: Colors.white.withOpacity(0.7099999785423279),
            //                               shape: RoundedRectangleBorder(
            //                                 borderRadius: BorderRadius.circular(24),
            //                               ),
            //                             ),
            //                           ),
            //                         ),
            //                         Positioned(
            //                           left: 3,
            //                           top: 0,
            //                           child: SizedBox(
            //                             width: 45,
            //                             height: 18,
            //                             child: Text(
            //                               '₹'+plantList[index].plantPrice,
            //                               textAlign: TextAlign.center,
            //                               style: GoogleFonts.acme(
            //                                 color: Color(0xFF20401B),
            //                                 fontSize: 15.50,
            //                                 fontWeight: FontWeight.w400,
            //                               ),
            //                             ),
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                   ),
            //                 ),
            //                 Positioned(
            //                   left: 12,
            //                   top: 135,
            //                   child: SizedBox(
            //                     width: 111,
            //                     height: 22.51,
            //                     child: Text(
            //                       plantList[index].plantCategory,
            //                       style: GoogleFonts.playfairDisplay(
            //                         color: Colors.white.withOpacity(0.7400000095367432),
            //                         fontSize: 12,
            //                         fontWeight: FontWeight.w400,
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //                 Positioned(
            //                   left: 13,
            //                   top: 40.31,
            //                   child: Container(
            //                     width: 40,
            //                     height: 43.45,
            //                     clipBehavior: Clip.antiAlias,
            //                     decoration: BoxDecoration(color: Colors.black.withOpacity(0)),
            //                     child: LikeButton(),
            //                   ),
            //                 ),
            //                 Positioned(
            //                   left: 61,
            //                   top: 0,
            //                   child: Container(
            //                     width: 69,
            //                     height: 115,
            //                     decoration: BoxDecoration(
            //                       image: DecorationImage(
            //                         image: AssetImage(plantList[index].plantImage),
            //                         fit: BoxFit.fill,
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           );
            //         },
            //       ),
            //     ),
            //     Container(
            //       padding: EdgeInsets.only(left:10),
            //       alignment: Alignment.topLeft,
            //
            //       child: Text("Recently Viewed",
            //           style: GoogleFonts.playfairDisplay(
            //             color: Color(0xFF0D0D0D),
            //             fontSize: 20,
            //
            //             fontWeight: FontWeight.w600,
            //           ),
            //           textAlign: TextAlign.left),
            //
            //
            //     ),
            // Container(
            //   height: 220,
            //   child: ListView.builder(
            //     scrollDirection: Axis.horizontal,
            //     itemCount: plantList.length,
            //     itemBuilder: (context, index) {
            //       return Container(
            //         width: 130, // Adjust the width of each item as needed
            //         margin: EdgeInsets.symmetric(horizontal: 10),
            //         child: Stack(
            //           children: [
            //             Positioned(
            //               left: 131,
            //               top: 190,
            //               child: Transform(
            //                 transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(-3.14),
            //                 child: Container(
            //                   width: 131,
            //                   height: 166,
            //                   decoration: ShapeDecoration(
            //                     gradient: LinearGradient(
            //                       begin: Alignment(0.00, -1.00),
            //                       end: Alignment(0, 1),
            //                       colors: [ Color(0xFF99A897),Color(0xFF50694C),Color(0xFF21411C)],
            //                     ),
            //                     shape: RoundedRectangleBorder(
            //                       borderRadius: BorderRadius.circular(24),
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //             ),
            //             Positioned(
            //               left: 12,
            //               top: 111,
            //               child: SizedBox(
            //                 width: 147,
            //                 height: 24,
            //                 child: Text(
            //                   plantList[index].plantName,
            //                   style: GoogleFonts.playfairDisplay(
            //                     color: Colors.white,
            //                     fontSize: 18,
            //                     fontWeight: FontWeight.w600,
            //                   ),
            //                 ),
            //               ),
            //             ),
            //             Positioned(
            //               left: 85,
            //               top: 145.34,
            //               child: Container(
            //                 width: 35,
            //                 height: 30.45,
            //                 clipBehavior: Clip.antiAlias,
            //                 decoration: BoxDecoration(color: Colors.black.withOpacity(0)),
            //                 child: IconButton(
            //                   onPressed: (){},
            //                   icon: Icon(Icons.shopping_cart),
            //                   color:Colors.white.withOpacity(0.7400000095367432),
            //                 ),
            //               ),
            //             ),
            //             Positioned(
            //               left: 13,
            //               top: 161,
            //               child: Container(
            //                 width: 55.23,
            //                 height: 18.57,
            //                 child: Stack(
            //                   children: [
            //                     Positioned(
            //                       left: 0,
            //                       top: 0,
            //                       child: Container(
            //                         width: 55.23,
            //                         height: 18.57,
            //                         decoration: ShapeDecoration(
            //                           color: Colors.white.withOpacity(0.7099999785423279),
            //                           shape: RoundedRectangleBorder(
            //                             borderRadius: BorderRadius.circular(24),
            //                           ),
            //                         ),
            //                       ),
            //                     ),
            //                     Positioned(
            //                       left: 3,
            //                       top: 0,
            //                       child: SizedBox(
            //                         width: 45,
            //                         height: 18,
            //                         child: Text(
            //                           '₹'+plantList[index].plantPrice,
            //                           textAlign: TextAlign.center,
            //                           style: GoogleFonts.acme(
            //                             color: Color(0xFF20401B),
            //                             fontSize: 15.50,
            //                             fontWeight: FontWeight.w400,
            //                           ),
            //                         ),
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             ),
            //             Positioned(
            //               left: 12,
            //               top: 135,
            //               child: SizedBox(
            //                 width: 111,
            //                 height: 22.51,
            //                 child: Text(
            //                   plantList[index].plantCategory,
            //                   style: GoogleFonts.playfairDisplay(
            //                     color: Colors.white.withOpacity(0.7400000095367432),
            //                     fontSize: 12,
            //                     fontWeight: FontWeight.w400,
            //                   ),
            //                 ),
            //               ),
            //             ),
            //             Positioned(
            //               left: 13,
            //               top: 40.31,
            //               child: Container(
            //                 width: 40,
            //                 height: 43.45,
            //                 clipBehavior: Clip.antiAlias,
            //                 decoration: BoxDecoration(color: Colors.black.withOpacity(0)),
            //                 child: LikeButton(),
            //               ),
            //             ),
            //             Positioned(
            //               left: 61,
            //               top: 0,
            //               child: Container(
            //                 width: 69,
            //                 height: 115,
            //                 decoration: BoxDecoration(
            //                   image: DecorationImage(
            //                     image: AssetImage(plantList[index].plantImage),
            //                     fit: BoxFit.fill,
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           ],
            //         ),
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

final List<Widget> onboardingPages = [
  // Add your onboarding pages here
  Image.asset(
    'assets/onBoard/ob3.jpg',
    fit: BoxFit.fill, // Adjust the fit property as needed
  ),
  Image.asset(
    'assets/onBoard/ob1.jpg',
    fit: BoxFit.fill,
  ),
  Image.asset(
    'assets/onBoard/ob2.jpg',
    fit: BoxFit.fill,
  ),
];

class PlantsData {
  final String plantImage;
  final String plantName;
  final String plantCategory;
  final String plantPrice;

  PlantsData(
      {required this.plantImage,
      required this.plantName,
      required this.plantCategory,
      required this.plantPrice});
}

class CategoryData {
  final String categoryImage;
  final String categoryName;

  CategoryData({required this.categoryImage, required this.categoryName});
}
