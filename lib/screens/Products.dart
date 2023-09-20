import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:plantbackend/screens/productDesc.dart';

import '../Animations/scale_animation.dart';
import 'fertilizers.dart';
class Products extends StatefulWidget {
 // const Products({Key? key}) : super(key: key);
  final String mainCategory;
  final GraphQLClient client;

  Products({required this.mainCategory, required this.client});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> with SingleTickerProviderStateMixin{

  bool isLiked = false;

  void _toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });
  }
  final HttpLink httpLink = HttpLink('http://192.168.1.112:8000/graphql/');

  late GraphQLClient client;

  final String fetchAllProductsQuery = r'''
    query FetchproductsByCategory($mainCategory: String!) {
      productsByCategory(mainCategory: $mainCategory){
    id
    productName
    description
    price
    size
    images
  }
    }

  ''';
  Map<String, bool> productLikedStates = {};


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
            backgroundColor: Colors.lightGreen[50],
            body: Query(
                options: QueryOptions(
                  document: gql(fetchAllProductsQuery),
                  variables: {'mainCategory': widget.mainCategory},
                ),
                builder: (QueryResult result, {fetchMore, refetch}) {
                  if (result.hasException) {
                    return Center(
                      child: Text(
                        'Error fetching plants: ${result.exception
                            .toString()}',
                      ),
                    );
                  }

                  if (result.isLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  List<dynamic> products =result.data?['productsByCategory'] as List;

                  //final List<dynamic> plants = result.data?['allPlants'] ?? [];
                  return Column(
                      children: [
                  // Add your heading here
                  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.only(top: 45, left: 80, bottom: 5),
                    width: double.infinity,
                    color: Colors.lightGreen[50],
                    child: Text(
                      widget.mainCategory.toUpperCase()+'S',
                      style: GoogleFonts.adamina(
                        fontSize: 35,
                        color: Color(0xFF50694C),
                        //fontWeight: FontWeight.w200,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  ),
                  Expanded(
                  child:GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.95,
                  //crossAxisSpacing: 2.0// Adjust this value to change card aspect ratio
                  ),

                  padding: EdgeInsets.only(left: 0, right: 0, top: 0),
                  scrollDirection: Axis.vertical,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                  final product = products[index];
                  final productId = product['id'];
                  final imageUrl = "http://192.168.1.112:8000/media/${product['images']}";
                  return Container(
                  width: 210,
                  // Adjust the width of each item as needed
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: GestureDetector(
                  onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                     builder: (context) => ProductDesc(productId: productId)));
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
                  borderRadius: BorderRadius
                      .circular(24),
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
                  product['productName'],
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
                  color: Colors.black.withOpacity(
                  0)),
                  child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.shopping_cart),
                  color: Colors.white.withOpacity(
                  0.7400000095367432),
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
                  color: Colors.white
                      .withOpacity(
                  0.7099999785423279),
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius
                      .circular(24),
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
                  '₹' + product['price']
                      .toString(),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.acme(
                  color: Color(0xFF20401B),
                  fontSize: 15.50,
                  fontWeight: FontWeight
                      .w400,
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
                          productLikedStates[product['id']] ?? false
                              ? Icons.favorite
                              : Icons.favorite_outline,
                          color: productLikedStates[product['id']] ?? false
                              ? Colors.red
                              : Colors.grey.withOpacity(0.5),
                        ),
                        onPressed: () async {
                          final productId = product['id'];

                          // Check if the product is liked or not
                          final isLiked = productLikedStates[productId] ?? false;

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
                                  'customerId': 1, // Replace with the actual customer ID.
                                  'productId': productId,
                                },
                              ),
                            );

                            if (result.hasException) {
                              print('Error adding to wishlist: ${result.exception.toString()}');
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


                  ),),
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
                  ),),)

                  ],
                  ),
                  ));
                  },
                  ),
                  ),
                      ],
                  );
                },
            ),
        ),
    );
  }
}
