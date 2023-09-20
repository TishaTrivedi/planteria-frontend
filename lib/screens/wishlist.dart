import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql/client.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:plantbackend/screens/soil.dart';

import '../Animations/scale_animation.dart';
import 'fertilizers.dart';

class WishList extends StatefulWidget {
  const WishList({Key? key}) : super(key: key);

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  final HttpLink httpLink = HttpLink('http://192.168.1.112:8000/graphql');

  late GraphQLClient client;
  bool isLiked = true;

  void _toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });
  }
  Map<String, bool> productLikedStates = {};


  void initState() {
    super.initState();
    client = GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(),

    );
  }

  @override
  Widget build(BuildContext context) {
    return Container( 
        child: Scaffold(
          backgroundColor: Colors.lightGreen.shade50,
          appBar: AppBar(
            backgroundColor: Color(0xFF3C593B),
            title: Text("My WishList",
              style: GoogleFonts.lora(
                fontWeight: FontWeight.w600,
              ),),
            leading: Icon(Icons.arrow_back),
            shadowColor: Color(0xFF2F482D),
          ),
          body: Query(
            options: QueryOptions(
              document: gql('''
              query {
                displayCustomerLikedPlantsById(customerId: 1) {
                  id
                  plantId {
                    plantName
                    category
                    price
                    images
                  }
                }
                displayCustomerLikedProductsById(customerId: 1) {
                  id
                  productId {
                    productName
                    price
                    images
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

              final likedPlants =
              result.data?['displayCustomerLikedPlantsById'] as List;
              final likedProducts =
              result.data?['displayCustomerLikedProductsById'] as List;

              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.95,
                ),
                padding: EdgeInsets.only(left: 0, right: 0, top: 0),
                scrollDirection: Axis.vertical,
                itemCount: likedPlants.length + likedProducts.length,
                itemBuilder: (context, index) {
                  if (index < likedPlants.length) {
                    final plant = likedPlants[index]['plantId'];
                    final plantName = plant['plantName'] ?? 'No Name';
                    final imageUrl =
                        "http://192.168.1.112:8000/media/${plant['images']}";
                    final price = '₹' + (plant['price'] ?? 'N/A').toString();
                    final category = plant['category'] ?? 'N/A';

                    return Container(
                      width: 210,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: GestureDetector(
                        onTap: () {
                          // Handle plant item click
                        },
                        child: Stack(
                          children: [

                      Positioned(
                        left: 160,
                        top: 190,
                        child: Transform(
                          transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(-3.14),
                          child: Container(
                            width: 160,
                            height: 156,
                            decoration: ShapeDecoration(
                              gradient: LinearGradient(
                                begin: Alignment(0.00, -1.00),
                                end: Alignment(0, 1),
                                colors: [ Color(0xFF99A897),Color(0xFF50694C),Color(0xFF21411C)],

                                // colors: [ Color(0xFF56887D),Color(0xFF317873),Color(0xFF004B49)],
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 12,
                        top: 111,
                        child: SizedBox(
                          width: 147,
                          height: 24,
                          child: Text(
                           plantName,
                            style: GoogleFonts.playfairDisplay(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 100,
                        top: 145.34,
                        child: Container(
                          width: 35,
                          height: 30.45,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(color: Colors.black.withOpacity(0)),
                          child: IconButton(
                            onPressed: (){},
                            icon: Icon(Icons.shopping_cart),
                            color:Colors.white.withOpacity(0.7400000095367432),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 12,
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
                                    color: Colors.white.withOpacity(0.7099999785423279),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24),
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
                                  // '$indexPosition',
                                    price,
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
                        top: 135,
                        child: SizedBox(
                          width: 111,
                          height: 22.51,
                          child: Text(
                          category,
                            style: GoogleFonts.playfairDisplay(
                              color: Colors.white.withOpacity(0.7400000095367432),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 13,
                        top: 45.31,
                        child: Container(
                          width: 40,
                          height: 43.45,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(
                                  0)),
                          child: IconButton(
                            icon: Icon(
                              Icons.favorite,
                              color: isLiked ? Colors.red : Colors.white,
                            ),
          //                   onPressed: () async {
          //                     if (isLiked) {
          //                       // If it's liked, remove it from the wishlist
          //                       final result = await client.mutate(
          //                         MutationOptions(
          //                           document: gql('''
          //   mutation RemoveFromWishlist(\$plantId: ID!) {
          //     removeProductFromWishlist(plantId: \$plantId) {
          //       id
          //       # Add other fields you need
          //     }
          //   }
          // '''),
          //                           variables: {
          //                             'plantId': plantId,
          //                           },
          //                         ),
          //                       );
          //
          //                       if (result.hasException) {
          //                         // Handle any errors that occur during the mutation
          //                         print('Error removing from wishlist: ${result.exception.toString()}');
          //                       } else {
          //                         // Mutation was successful, remove the plant from the UI
          //                         setState(() {
          //                           // Remove the plant from your Likedplants list
          //                           Likedplants.removeWhere((item) => item['plantId']['id'] == plantId);
          //                         });
          //                       }
          //                     } else {
          //                       // If it's not liked, add it to the wishlist (similar to your existing code)
          //                       final result = await client.mutate(
          //                         MutationOptions(
          //                           document: gql('''
          //   mutation AddToWishlist(\$plantId: ID!) {
          //     addProductToWishlist(plantId: \$plantId) {
          //       id
          //       # Add other fields you need
          //     }
          //   }
          // '''),
          //                           variables: {
          //                             'plantId': plantId,
          //                           },
          //                         ),
          //                       );
          //
          //                       if (result.hasException) {
          //                         // Handle any errors that occur during the mutation
          //                         print('Error adding to wishlist: ${result.exception.toString()}');
          //                       } else {
          //                         // Mutation was successful, update the like status locally
          //                         setState(() {
          //                           isLiked = !isLiked;
          //                         });
          //                         print("Removed successfully");
          //                       }
          //                     }
          //                   },
                            onPressed: (){},
                            color: Colors.white,
                          ),

                        ),),
                      Positioned(
                        left: 71,
                        top: -10,

                        child:Container(
                          width: 89,
                          height: 132,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(imageUrl),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),),

                    ],
                  )));


                  } else {
                    final product = likedProducts[index - likedPlants.length]
                    ['productId'];
                    final productId=product['id']?? 'No id';
                    final productName = product['productName'] ?? 'No Name';
                    final imageUrl =
                        "http://192.168.1.112:8000/media/${product['images']}";
                    final price = '₹' + (product['price'] ?? 'N/A').toString();

                    return Container(
                      width: 210,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: GestureDetector(
                        onTap: () {
                          // Handle product item click
                        },
                        child: Stack(
                          children: [

                            Positioned(
                              left: 160,
                              top: 190,
                              child: Transform(
                                transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(-3.14),
                                child: Container(
                                  width: 160,
                                  height: 156,
                                  decoration: ShapeDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment(0.00, -1.00),
                                      end: Alignment(0, 1),
                                      colors: [ Color(0xFF99A897),Color(0xFF50694C),Color(0xFF21411C)],

                                      // colors: [ Color(0xFF56887D),Color(0xFF317873),Color(0xFF004B49)],
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 12,
                              top: 111,
                              child: SizedBox(
                                width: 147,
                                height: 24,
                                child: Text(
                                  productName,
                                  style: GoogleFonts.playfairDisplay(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 100,
                              top: 145.34,
                              child: Container(
                                width: 35,
                                height: 30.45,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(color: Colors.black.withOpacity(0)),
                                child: IconButton(
                                  onPressed: (){},
                                  icon: Icon(Icons.shopping_cart),
                                  color:Colors.white.withOpacity(0.7400000095367432),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 12,
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
                                          color: Colors.white.withOpacity(0.7099999785423279),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(24),
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
                                          // '$indexPosition',
                                          price,
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
                              left: 13,
                              top: 45.31,
                              child: Container(
                                width: 40,
                                height: 43.45,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(
                                        0)),
                                child:IconButton(
                                  icon: Icon(
                                    Icons.favorite,
                                    color: productLikedStates[product['id']] ?? true ? Colors.red : Colors.grey.withOpacity(0.5),
                                  ),
                                  onPressed: () async {
                                    final productId = product['id'];

                                    // Check if the product is liked or not
                                    final isLiked = productLikedStates[productId] ?? true;

                                    // If the product is liked, remove it from the wishlist
                                    if (isLiked) {
                                      try {
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
                                              'customerId': 1, // Replace with the actual customer ID.
                                              'productId': productId,
                                            },
                                          ),
                                        );

                                        if (result.hasException) {
                                          print('Error removing from wishlist: ${result.exception.toString()}');
                                        } else {
                                          setState(() {
                                            productLikedStates[productId] = false;
                                            print("Removed successfully");
                                          });
                                        }
                                      } catch (e) {
                                        print('Error executing the mutation: $e');
                                      }
                                    } else {
                                      // If the product is not liked, you can handle it differently here,
                                      // such as showing a message or taking other actions.
                                      print("Product is not liked, no action taken.");
                                    }
                                  },
                                  color: Colors.grey,
                                )
                              )),

                                Positioned(
                              left: 71,
                              top: -10,

                              child:Container(
                                width: 89,
                                height: 132,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(imageUrl),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),),

                          ],
                        )));


                  }
                },
              );
            },
          ),
        ),
    );
  }
}






