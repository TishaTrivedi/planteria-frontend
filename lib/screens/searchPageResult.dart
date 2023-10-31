import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql/client.dart';
import 'package:plantbackend/screens/productDesc.dart';

import '../Animations/scale_animation.dart';
import '../graphql_client.dart';
import '../login/registration.dart';

class SearchResultsPage extends StatefulWidget {
  //const SearchResultsPage({Key? key}) : super(key: key);
  final List<Map<String, dynamic>> searchResults;

  SearchResultsPage(this.searchResults);

  @override
  _SearchResultsPageState createState() => _SearchResultsPageState();
  // @override
  // State<SearchResultsPage> createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  Map<String, bool> productLikedStates = {};
  int quant = 1;
  bool isLiked = false;
  bool productRemoved = false;

  void _toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });
  }

  late GraphQLClient client;
  @override
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
          title: Text(
            "Search results",
            style: GoogleFonts.lora(
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back)),
          shadowColor: Color(0xFF2F482D),
        ),
        body: widget.searchResults.isEmpty
            ? Center(
          // If there are no search results, show a text message
          child: Text(
            'Sorry No results found',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        )
            :GridView.builder(
          gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.95,
            //crossAxisSpacing: 2.0// Adjust this value to change card aspect ratio
          ),
          padding: const EdgeInsets.only(left: 0, right: 0, top: 0),
          scrollDirection: Axis.vertical,
          itemCount: widget.searchResults.length,
          itemBuilder: (context, index) {
            final product = widget.searchResults[index];
            final productId = product['id'];
            final imageUrl = "${httpLinkImage}${product['images']}";
            return Container(
                width: 210,
                // Adjust the width of each item as needed
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: GestureDetector(
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProductDesc(productId: productId)));
                    final addToRecentlyViewedMutation = gql('''
mutation AddToRecentlyViewed(\$productId: ID!, \$userId: ID!) {
  addToRecentlyViewed(customerId: \$userId, itemId: \$productId, itemType: "product") {
    recentlyViewed {
      productId {
        productName
        images
        price
      }
    }
  }
}
''');
                    try {
                      final result = await client.mutate(
                        MutationOptions(
                          document: addToRecentlyViewedMutation,
                          variables: {'productId': product['id'],
                            'userId': UserFormFields.userId,
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

                        print('Product added to recently Viewed. }');
                      }
                    } catch (error) {
                      // Handle any unexpected errors here.
                      print('Unexpected error: $error');
                    }
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
                              gradient: const LinearGradient(
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
                        top: 105,
                        child: SizedBox(
                          width: 105,
                          height: 48,
                          child: Text(
                            product['productName'],
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
                                          mutation AddToCart(\$productId: ID!, \$quantity: Int!,\$userId: ID!) {
                                            addToCart(customerId:\$userId , itemId: \$productId, itemType: "product", quantity: \$quantity) {
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
                                      quant,
                                      'userId': UserFormFields.userId,// Specify the quantity you want to add to the cart
// Specify the quantity you want to add to the cart
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
                                    const SnackBar(
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
                            icon: const Icon(Icons.shopping_cart),
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
                                    '₹' + product['price'].toString(),
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.acme(
                                      color: const Color(0xFF20401B),
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
                                productLikedStates[product['id']] ??
                                    false
                                    ? Icons.favorite
                                    : Icons.favorite_outline,
                                color: productLikedStates[
                                product['id']] ??
                                    false
                                    ? Colors.red
                                    : Colors.grey.withOpacity(0.5),
                              ),
                              onPressed: () async {
                                final productId = product['id'];

                                // Check if the product is liked or not
                                final isLiked =
                                    productLikedStates[productId] ??
                                        false;

                                // If the product is not liked, add it to the wishlist
                                if (!isLiked) {
                                  final result = await client.mutate(
                                    MutationOptions(
                                      document: gql('''
            mutation addProductsToWishlist(\$productId: ID!,\$userId: ID!) {
              addProductsToWishlist(customerId: \$userId, productId: \$productId) {
                savedProduct {
                  id
                }
              }
            }
          '''),
                                      variables: {
                                        // Replace with the actual customer ID.
                                        'productId': productId,
                                        'userId': UserFormFields.userId,// Specify the quantity you want to add to the cart

                                      },
                                    ),
                                  );

                                  if (result.hasException) {
                                    print(
                                        'Error adding to wishlist: ${result.exception.toString()}');
                                  } else {
                                    setState(() {
                                      productLikedStates[productId] =
                                      true;
                                      print("Added successfully");
                                      setState(() {
                                        productRemoved = true;
                                      });
                                      //print('Item removed from cart successfully.');
                                      // Show a Snackbar with the success message
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              'Product Added to wishlist successfully.'),
                                          duration: Duration(
                                              seconds:
                                              2), // You can adjust the duration
                                        ),
                                      );
                                    });
                                  }
                                } else {
                                  // If the product is liked, remove it from the wishlist
                                  final result = await client.mutate(
                                    MutationOptions(
                                      document: gql('''
                                  mutation removeProductsFromWishlist(\$userID: ID!, \$productId: ID!) {
                                    removeProductsFromWishlist(customerId: \$userID, productId: \$productId) {
                                      deletedCount
                                    }
                                  }
                                '''),
                                      variables: {
                                        'userID':
                                        UserFormFields.userId, // Replace with the actual customer ID.
                                        'productId': productId,
                                      },
                                    ),
                                  );

                                  if (result.hasException) {
                                    print(
                                        'Error removing from wishlist: ${result.exception.toString()}');
                                  } else {
                                    setState(() {
                                      productLikedStates[productId] =
                                      false;
                                      print("Removed successfully");
                                      setState(() {
                                        productRemoved = true;
                                      });
                                      print(
                                          'Item removed from cart successfully.');
                                      // Show a Snackbar with the success message
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              'Product removed from wishlist successfully.'),
                                          duration: Duration(
                                              seconds:
                                              2), // You can adjust the duration
                                        ),
                                      );
                                    });
                                  }
                                }
                              },
                              color: Colors.grey,
                            )

                          // IconButton(
                          //   icon: Icon(
                          //     Icons.favorite_outlined,
                          //     color: (productLikedStates[product['id']] ?? false) ? Colors.red : Colors.grey.withOpacity(0.5),
                          //   ),
                          //   onPressed: () async {
                          //     print("product['id']: ${product['id']}"); // Debug statement
                          //     final result = await client.mutate(
                          //       MutationOptions(
                          //         document: gql('''
                          //         mutation addProductsToWishlist(\$productId: ID!) {
                          //           addProductsToWishlist(customerId: 1, productId: \$productId) {
                          //             savedProduct {
                          //               id
                          //             }
                          //           }
                          //         }
                          //       '''),
                          //         variables: {
                          //           'productId': product['id'],
                          //         },
                          //       ),
                          //     );
                          //
                          //     if (result.hasException) {
                          //       print('Error adding to wishlist: ${result.exception.toString()}');
                          //     } else {
                          //       setState(() {
                          //         productLikedStates[product['id']] = !(productLikedStates[product['id']] ?? false);
                          //         print("Added successfully");
                          //       });
                          //     }
                          //   },
                          //   color: Colors.grey,
                          // )

                        ),
                      ),
                      Positioned(
                        left: 71,
                        top: -10,
                        child: ScaleAnimation(
                          begin: 0.06,
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
                      )
                    ],
                  ),
                ));
          },
        ),
      ),
    );
  }
}


