import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql/client.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:plantbackend/screens/productDesc.dart';
import 'package:plantbackend/screens/soil.dart';

import '../Animations/scale_animation.dart';
import '../graphql_client.dart';
import 'fertilizers.dart';

class WishList extends StatefulWidget {
  const WishList({Key? key}) : super(key: key);

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  bool productRemoved = false;

  late GraphQLClient client;

  void initState() {
    super.initState();
    client = GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs (Plants and Products)
      child: Scaffold(
        backgroundColor: Colors.lightGreen.shade50,
        appBar: AppBar(
          backgroundColor: Color(0xFF3C593B),
          title: Text(
            "My WishList",
            style: GoogleFonts.lora(
              fontWeight: FontWeight.w600,
            ),
          ),
          shadowColor: Color(0xFF2F482D),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Plants'), // First tab for Plants
              Tab(text: 'Products'), // Second tab for Products
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Content for the Plants tab
            Query(
              options: QueryOptions(
                document: gql('''
                              query {
                                displayCustomerLikedPlantsById(customerId: 1) {
                                  id
                                  plantId {
                                    id
                                    plantName
                                    category
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
                Map<String, bool> plantLikedStates = {};
                final likedPlants =
                    result.data?['displayCustomerLikedPlantsById'] as List;

                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.95,
                  ),
                  padding: EdgeInsets.all(0),
                  scrollDirection: Axis.vertical,
                  itemCount: likedPlants.length,
                  itemBuilder: (context, index) {
                    final plant = likedPlants[index]['plantId'];
                    final plantName = plant['plantName'] ?? 'No Name';
                    final imageUrl = "${httpLinkImage}${plant['images']}";
                    final price = '₹' + (plant['price'] ?? 'N/A').toString();
                    final category = plant['category'] ?? 'N/A';
                    bool isLiked = false;

                    return Container(
                        width: 210,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Fertilizers(plantId: plant['id'])));
                              // Handle plant item click
                            },
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 160,
                                  top: 190,
                                  child: Transform(
                                    transform: Matrix4.identity()
                                      ..translate(0.0, 0.0)
                                      ..rotateZ(-3.14),
                                    child: Container(
                                      width: 160,
                                      height: 156,
                                      decoration: ShapeDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment(0.00, -1.00),
                                          end: Alignment(0, 1),
                                          colors: [
                                            Color(0xFF99A897),
                                            Color(0xFF50694C),
                                            Color(0xFF21411C)
                                          ],

                                          // colors: [ Color(0xFF56887D),Color(0xFF317873),Color(0xFF004B49)],
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
                                    decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0)),
                                    child: IconButton(
                                      onPressed: () async {
                                        final addProductToCartMutation = gql('''
                                          mutation AddToCart(\$plantId: ID!, \$quantity: Int!) {
                                            addToCart(customerId: 1, itemId: \$plantId, itemType: "plant", quantity: \$quantity) {
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
                                              document:
                                                  addProductToCartMutation,
                                              variables: {
                                                'plantId': plant['id'],
                                                'quantity':
                                                    1, // Specify the quantity you want to add to the cart
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
                                            print('Plant added to cart.');
                                            setState(() {
                                              productRemoved = true;
                                            });
                                            //print('Item removed from cart successfully.');
                                            // Show a Snackbar with the success message
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    'Plant added to cart.'),
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
                                  top: 45.31,
                                  child: Container(
                                    width: 40,
                                    height: 43.45,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0)),
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.favorite,
                                        color: plantLikedStates[plant] ?? true
                                            ? Colors.red
                                            : Colors.white,
                                      ),
                                      onPressed: () async {
                                        // If it's liked, remove it from the wishlist
                                        final plantId = plant['id'];

                                        // Check if the product is liked or not
                                        final isLiked =
                                            plantLikedStates[plantId] ?? true;

                                        if (isLiked) {
                                          // If the product is liked, remove it from the wishlist
                                          if (plantId != null) {
                                            // Add this null check
                                            final result = await client.mutate(
                                              MutationOptions(
                                                document: gql('''
                         mutation removePlantsFromWishlist(\$customerId: ID!, \$plantId: ID!) {
                          removePlantsFromWishlist(customerId: \$customerId, plantId: \$plantId) {
                          deletedCount
                                                  }
                                                }
                                              '''),
                                                variables: {
                                                  'customerId':
                                                      1, // Replace with the actual customer ID.
                                                  'plantId': plantId,
                                                },
                                              ),
                                            );

                                            if (result.hasException) {
                                              print(
                                                  'Error removing from wishlist: ${result.exception.toString()}');
                                            } else {
                                              setState(() {
                                                plantLikedStates[plantId] =
                                                    false;
                                                print("Removed successfully");
                                                setState(() {
                                                  productRemoved = true;
                                                });
                                                //print('Item removed from cart successfully.');
                                                // Show a Snackbar with the success message
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                        'Removed from wishlist successfully.'),
                                                    duration: Duration(
                                                        seconds:
                                                            2), // You can adjust the duration
                                                  ),
                                                );
                                              });
                                            }
                                          }
                                        } else {
                                          print(
                                              "Product is not liked, no action taken.");
                                        }
                                      },
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 71,
                                  top: -10,
                                  child: Container(
                                    width: 89,
                                    height: 132,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(imageUrl),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )));
                  },
                );
              },
            ),
            Query(
              options: QueryOptions(
                document: gql('''
                                  query {
                                    displayCustomerLikedProductsById(customerId: 1) {
                                      id
                                      productId {
                                      id
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
                Map<String, bool> productLikedStates = {};
                final likedProducts =
                    result.data?['displayCustomerLikedProductsById'] as List;
                print(result);
                // likedProducts.forEach((product) {
                //   final productId = product['productId']['id'];
                //   productLikedStates[productId] = true;
                // });
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.95,
                  ),
                  padding: EdgeInsets.all(0),
                  scrollDirection: Axis.vertical,
                  itemCount: likedProducts.length,
                  itemBuilder: (context, index) {
                    final product = likedProducts[index]['productId'];
                    //final productId=product['id']?? 'No id';
                    final productName = product['productName'] ?? 'No Name';
                    final imageUrl = "${httpLinkImage}${product['images']}";
                    final price = '₹' + (product['price'] ?? 'N/A').toString();
                    //print(productId);
                    // bool isLiked = false;

                    return Container(
                        width: 210,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProductDesc(
                                          productId: product['id'])));
                              // Handle product item click
                            },
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 160,
                                  top: 190,
                                  child: Transform(
                                    transform: Matrix4.identity()
                                      ..translate(0.0, 0.0)
                                      ..rotateZ(-3.14),
                                    child: Container(
                                      width: 160,
                                      height: 156,
                                      decoration: ShapeDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment(0.00, -1.00),
                                          end: Alignment(0, 1),
                                          colors: [
                                            Color(0xFF99A897),
                                            Color(0xFF50694C),
                                            Color(0xFF21411C)
                                          ],

                                          // colors: [ Color(0xFF56887D),Color(0xFF317873),Color(0xFF004B49)],
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
                                    decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0)),
                                    child: IconButton(
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
                                              document:
                                                  addProductToCartMutation,
                                              variables: {
                                                'productId': product['id'],
                                                'quantity':
                                                    1, // Specify the quantity you want to add to the cart
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
                                            setState(() {
                                              productRemoved = true;
                                            });
                                            //print('Item removed from cart successfully.');
                                            // Show a Snackbar with the success message
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    'Product Added to cart successfully.'),
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
                                            color: Colors.black.withOpacity(0)),
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.favorite,
                                            color: productLikedStates[
                                                        product['id']] ??
                                                    true
                                                ? Colors.red
                                                : Colors.grey.withOpacity(0.5),
                                          ),
                                          onPressed: () async {
                                            final productId = product['id'];

                                            // Check if the product is liked or not
                                            final isLiked =
                                                productLikedStates[productId] ??
                                                    true;

                                            if (isLiked) {
                                              // If the product is liked, remove it from the wishlist
                                              if (productId != null) {
                                                // Add this null check
                                                final result =
                                                    await client.mutate(
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
                                                    productLikedStates[
                                                        productId] = false;
                                                    print(
                                                        "Removed successfully");
                                                    setState(() {
                                                      productRemoved = true;
                                                    });
                                                    //print('Item removed from cart successfully.');
                                                    // Show a Snackbar with the success message
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                            'Removed from wishlist successfully.'),
                                                        duration: Duration(
                                                            seconds:
                                                                2), // You can adjust the duration
                                                      ),
                                                    );
                                                  });
                                                }
                                              }
                                            } else {
                                              print(
                                                  "Product is not liked, no action taken.");
                                            }
                                          },
                                          color: Colors.grey,
                                        ))),
                                Positioned(
                                  left: 71,
                                  top: -10,
                                  child: Container(
                                    width: 89,
                                    height: 132,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(imageUrl),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )));
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
