import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql/client.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../Animations/slide_animation.dart';
import '../graphql_client.dart';

class ProductDesc extends StatefulWidget {
  //const ProductDesc({Key? key}) : super(key: key);

  late final String productId;
  ProductDesc({required this.productId});
  @override
  State<ProductDesc> createState() => _ProductDescState();
}

class _ProductDescState extends State<ProductDesc> {
  late TabController _tabController;
  int quant = 1;
  void increment() {
    setState(() {
      quant++;
    });
  }

  void decrement() {
    setState(() {
      if (quant > 1) {
        quant--;
      }
    });
  }

  late GraphQLClient client;

  final String fetchProductQuery = r'''
    query($id: ID!) {
      productsById(id: $id) {
        id
        productName
        description        
        price        
        size
        images  
       
        
      }
    }
  ''';
  @override
  void initState() {
    super.initState();
    client = GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(),
    );

    quant = 1;
  }

  @override
  bool isLiked = false;

  void _toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });
  }

  Map<String, bool> productLikedStates = {};

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      backgroundColor: Colors.lightGreen.shade50,
      body: Query(
          options: QueryOptions(document: gql(fetchProductQuery), variables: {
            'id': widget.productId,
          } // Replace with the actual plant ID
              ),
          builder: (QueryResult result, {fetchMore, refetch}) {
            if (result.hasException) {
              return Center(
                child: Text(
                  'Error fetching plants: ${result.exception.toString()}',
                ),
              );
            }

            if (result.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            final Map<String, dynamic> products = result.data?['productsById'];
            return SingleChildScrollView(
              child: Container(
                width: 371,
                height: 1700,
                color: Colors.lightGreen.shade50,
                child: Stack(
                  children: [
                    Positioned(
                        left: 30,
                        top: 700,
                        child: Container(
                          width: 350,
                          height: 500,
                          padding: EdgeInsets.only(right: 40),
                          child: Center(
                            child: Text(
                              "•	The image displayed is indicative in nature.\n•	Actual product may vary in shape or design as per the availability.\n•	The number of leaves and the size of the plant depends on seasonal availability.\n•	Since flowers are seasonal in nature, flowering plants may be delivered without the bloom. Flowers, if present in plant, may be in fully bloomed, semi-bloomed or bud stage.\n•	Pots will be provided as per the requirement of the plant.\n•	Delivery will be attempted on the same day, but there may be a delay of 3-5 hours depending on the traffic and the weather.\n•	Our courier partners do not call prior to delivering an order, so we recommend that you provide an address at which someone will be present to receive the package.\n•	The delivery, once dispatched, cannot be redirected to any other address.",
                              style: GoogleFonts.playfairDisplay(
                                color: Colors.black,
                                fontSize: 13,
                                // fontFamily: 'Playfair Display',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        )),
                    Positioned(
                      left: -152,
                      top: -45,
                      child: Container(
                        width: 722,
                        height: 1156,
                        child: Stack(
                          children: [
                            Positioned(
                                left: 170.67,
                                top: 620.79,
                                child: Container(
                                    height: 150,
                                    width: 320,
                                    decoration: ShapeDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment(0.00, -1.00),
                                        end: Alignment(0, 1),
                                        colors: [
                                          Color(0xFDBBDA9B).withOpacity(0.4),
                                          Color(0xFDC8DEAE).withOpacity(0.4),
                                        ],
                                      ),
                                      // color: Colors.lightGreen[100],
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                    ),
                                    padding: EdgeInsets.only(
                                        left: 10, right: 10, top: 10),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Text(
                                        //textAlign: TextAlign.center,
                                        products['description'],
                                        style: GoogleFonts.playfairDisplay(
                                          color: Colors.black,
                                          fontSize: 13,
                                          // fontFamily: 'Playfair Display',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ))),
                            Positioned(
                              left: 250.67,
                              top: 400.79,
                              child: SizedBox(
                                width: 150.22,
                                height: 100.03,
                                child: Text(
                                  products['productName'],
                                  style: GoogleFonts.playfairDisplay(
                                    color: Colors.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                ),
                              ),
                            ),

                            Positioned(
                              left: 420.27,
                              top: 130.96,
                              child: SizedBox(
                                width: 120.10,
                                height: 31.12,
                                child: Text(
                                  '₹' + products['price'].toString(),
                                  style: GoogleFonts.acme(
                                    color: Colors.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w200,
                                  ),
                                ),
                              ),
                            ),

                            Positioned(
                              left: 420.21,
                              top: 102.33,
                              child: SizedBox(
                                width: 120.10,
                                height: 31.12,
                                child: Text(
                                  products['size'],
                                  style: GoogleFonts.acme(
                                    color: Colors.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w200,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 180.59,
                              top: 30.15,
                              child: SlideAnimation(
                                duration: Duration(seconds: 1),
                                child: Container(
                                  width: 288.62,
                                  height: 406.84,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          "${httpLinkImage}${products['images']}"),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            Positioned(
                                top: 100,
                                left: 167.24,
                                child: IconButton(
                                  icon: Icon(
                                    productLikedStates[products['id']] ?? false
                                        ? Icons.favorite
                                        : Icons.favorite_outline,
                                    color: productLikedStates[products['id']] ??
                                            false
                                        ? Colors.red
                                        : Colors.grey.withOpacity(0.5),
                                  ),
                                  onPressed: () async {
                                    final productId = products['id'];

                                    // Check if the product is liked or not
                                    final isLiked =
                                        productLikedStates[productId] ?? false;

                                    // If the product is not liked, add it to the wishlist
                                    if (!isLiked) {
                                      final result = await client.mutate(
                                        MutationOptions(
                                          document: gql('''
                                              mutation addProductsToWishlist(\$customerId: ID!, \$productId: ID!) {
                                                addProductsToWishlist(customerId: \$customerId, productId: \$productId) {
                                                  savedProduct {
                                                    id
                                                  }
                                                }
                                              }
                                            '''),
                                          variables: {
                                            'customerId':
                                                1, // Replace with the actual customer ID.
                                            'productId': productId,
                                          },
                                        ),
                                      );

                                      if (result.hasException) {
                                        print(
                                            'Error adding to wishlist: ${result.exception.toString()}');
                                      } else {
                                        setState(() {
                                          productLikedStates[productId] = true;
                                          print("Added successfully");
                                        });
                                      }
                                    } else {
                                      // If the product is liked, remove it from the wishlist
                                      final result = await client.mutate(
                                        MutationOptions(
                                          document: gql('''
                                  mutation removeProductsFromWishlist(\$customerId: ID!, \$productId: ID!) {
                                    removeProductsFromWishlist(customerId: \$customerId, productId: \$productId) {
                                      deletedCount
                                    }
                                  }
                                '''),
                                          variables: {
                                            'customerId':
                                                1, // Replace with the actual customer ID.
                                            'productId': productId,
                                          },
                                        ),
                                      );

                                      if (result.hasException) {
                                        print(
                                            'Error removing from wishlist: ${result.exception.toString()}');
                                      } else {
                                        setState(() {
                                          productLikedStates[productId] = false;
                                          print("Removed successfully");
                                        });
                                      }
                                    }
                                  },
                                  color: Colors.grey,
                                )),
                            // TabView
                            Positioned(
                              left: 176,
                              top: 585,
                              child: SizedBox(
                                width: 326,
                                height: 27,
                                child: Text(
                                  'Description:',
                                  style: GoogleFonts.playfairDisplay(
                                    color: Colors.black,
                                    fontSize: 20,
                                    // fontFamily: 'Playfair Display',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 176,
                              top: 785,
                              child: SizedBox(
                                width: 326,
                                height: 27,
                                child: Text(
                                  'Product Delivery Information:',
                                  style: GoogleFonts.playfairDisplay(
                                    color: Colors.black,
                                    fontSize: 20,
                                    // fontFamily: 'Playfair Display',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),

                            Positioned(
                              left: 267,
                              top: 485,
                              child: Container(
                                width: 125,
                                height: 29.17,
                                decoration: ShapeDecoration(
                                  color: Color(0xFF21411C),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 262,
                              top: 482,
                              child: SizedBox(
                                  width: 133,
                                  height: 31.12,
                                  child: Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          decrement();
                                        },
                                        icon: Icon(
                                            Icons.remove_circle_outline_sharp,
                                            color: Colors.white,
                                            size: 20),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                        '$quant',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontFamily: 'Playfair Display',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          increment();
                                        },
                                        icon: Icon(
                                            Icons.add_circle_outline_sharp,
                                            color: Colors.white,
                                            size: 20),
                                      ),
                                    ],
                                  )),
                            ),

                            // Positioned(
                            //   left: 232,
                            //   top: 527,
                            //   child: Container(
                            //     width: 191.77,
                            //     height: 32.09,
                            //     decoration: ShapeDecoration(
                            //       color: Color(0xFF21411C),
                            //       shape: RoundedRectangleBorder(
                            //         borderRadius: BorderRadius.circular(24),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            Positioned(
                                left: 232,
                                top: 527.68,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    final addProductToCartMutation = gql('''
                                          mutation AddToCart(\$productId: ID!, \$quantity: Int!) {
                                            addToCart(customerId: 1, itemId: \$productId, itemType: "product", quantity: \$quantity) {
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
                                          document: addProductToCartMutation,
                                          variables: {
                                            'productId': products['id'],
                                            'quantity':
                                                quant, // Specify the quantity you want to add to the cart
                                          },
                                        ),
                                      );

                                      if (result.hasException) {
                                        // Handle the error here.
                                        print(
                                            'Error: ${result.exception.toString()}');
                                        // You can also show an error message to the user.
                                      } else {
                                        // Product added to cart successfully.
                                        // You can update the UI or show a confirmation message.
                                        print('Product added to cart.');
                                      }
                                    } catch (error) {
                                      // Handle any unexpected errors here.
                                      print('Unexpected error: $error');
                                    }
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.shopping_cart,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Add To Cart',
                                        style: GoogleFonts.playfairDisplay(
                                          color: Colors.white,
                                          fontSize: 20,
                                          //fontFamily: 'Playfair Display',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF21411C),
                                    minimumSize: Size(191.77, 32),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                  ),
                                )

                                // SizedBox(
                                //   width: 165.95,
                                //   height: 26.46,
                                //   child:
                                //   Row(
                                //     children: [
                                //       Icon(Icons.shopping_cart,
                                //         color: Colors.white,
                                //         size: 18,),
                                //       SizedBox(
                                //         width: 10,
                                //       ),
                                //       Text(
                                //         'Add To Cart',
                                //         style: GoogleFonts.playfairDisplay(
                                //           color: Colors.white,
                                //           fontSize: 20,
                                //           //fontFamily: 'Playfair Display',
                                //           fontWeight: FontWeight.w700,
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    ));
  }
}
