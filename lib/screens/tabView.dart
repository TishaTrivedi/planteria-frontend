import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantbackend/screens/soil.dart';
import 'package:plantbackend/screens/zodiac.dart';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../Animations/scale_animation.dart';
import '../graphql_client.dart';
import 'fertilizers.dart';

class TabView extends StatelessWidget {
  final List<Tab> myTabs = [
    Tab(text: 'All'),
    Tab(text: 'Zodiac'),
    Tab(text: 'Medicinal'),
    Tab(text: 'Air-purifying'),
    Tab(text: 'Flowering'),
    Tab(text: 'Pet-friendly'),
    Tab(text: 'Low-maintenance'),
  ];

  @override
  Widget build(BuildContext context) {// Replace with your GraphQL endpoint.

    final GraphQLClient client = GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(),
    );

    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 45, left: 125, bottom: 5),
                    width: double.infinity,
                    color: Colors.lightGreen[50],
                    child: Text(
                      "Plants",
                      style:  GoogleFonts.adamina(
                        fontSize: 35,
                        color: Color(0xFF50694C),
                        fontWeight: FontWeight.w200,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Container(
                    color: Colors.lightGreen[50],
                    child: TabBar(
                      isScrollable: true,
                      tabs: myTabs,
                      labelColor: Color(0xFF21411C),
                      indicatorColor: Color(0xFF21411C),
                      unselectedLabelColor: Color(0xFF50694C),
                      indicatorWeight: 1.5,
                      indicatorSize: TabBarIndicatorSize.label,
                    ),
                  ),
                ],
              ),
            ),
            SliverFillRemaining(
              child: TabBarView(
                children: [
                  Soil(category: 'All', client: client,fetchAllPlants: true),
                  Soil(category: 'zodiac', client: client),
                  Soil(category: 'medicinal', client: client),
                  Soil(category: 'air_purifying', client: client),
                  Soil(category: 'flowering', client: client),
                  Soil(category: 'pet-friendly', client: client),
                  Soil(category: 'low_maintain', client: client),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Soil extends StatefulWidget {
 // const Soil({Key? key}) : super(key: key);
  final String category;
  final GraphQLClient client;
  final bool fetchAllPlants;

  Soil({required this.category, required this.client,this.fetchAllPlants=false});
  @override
  State<Soil> createState() => _SoilState();
}

class _SoilState extends State<Soil> with SingleTickerProviderStateMixin {

  int quant=1;
  bool isLiked = false;
  bool productRemoved=false;

  void _toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });
  }

  Map<String, bool> plantLikedStates = {};

  late GraphQLClient client;

  final String fetchPlantsByCategoryQuery = '''
      query FetchPlantsByCategory(\$category: String!) {
        plantsByCategory(category: \$category) {
          id
          plantName
          price
          subcategory
          category
          images
          # Add other fields you need
        }
      }
    ''';
  final String fetchAllPlantsQuery = r'''
    query {
      allPlants {
        id
      plantName
      price
      subcategory
      category
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

  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
            backgroundColor: Colors.lightGreen[50],
            body: Query(
                options: QueryOptions(
                  document: gql(widget.fetchAllPlants ? fetchAllPlantsQuery : fetchPlantsByCategoryQuery),
                  variables: {'category': widget.category},
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
                  List<dynamic> plants;

                  if (widget.fetchAllPlants) {
                    plants = result.data?['allPlants'] as List;
                  } else {
                    plants = result.data?['plantsByCategory'] as List;
                  }
                  //print(result);
                  //final List<dynamic> plants = result.data?['allPlants'] ?? [];
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.95,
                      //crossAxisSpacing: 2.0// Adjust this value to change card aspect ratio
                    ),

                    padding: EdgeInsets.only(left: 0, right: 0, top: 0),
                    scrollDirection: Axis.vertical,
                    itemCount: plants.length,
                    itemBuilder: (context, index) {
                      final plant = plants[index];
                      final plantId = plant['id'];
                      final imageUrl = "${httpLinkImage}${plant['images']}";
                      // plantLikedStates[plant['id']] = false;


                      return Container(
                          width: 210,
                          // Adjust the width of each item as needed
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: GestureDetector(
                            onTap: () async {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => Fertilizers(plantId: plantId,)));
                              final addToRecentlyViewedMutation=gql('''
                              mutation AddToRecentlyViewed(\$plantId: ID!) {
                                addToRecentlyViewed(customerId:1,itemId:\$plantId,itemType:"plant"){
                                  recentlyViewed{
                                    plantId{
                                       plantName
                                      price
                                      category
                                      images
                                    }
                                   
                                  }
                                }
                              }
                              ''');
                            try {
                            final result = await client.mutate(
                            MutationOptions(
                            document: addToRecentlyViewedMutation,
                            variables: {'plantId': plant['id']},
                            ),
                            );

                            if (result.hasException) {
                            // Handle the error here.
                            print('Error: ${result.exception.toString()}');
                            // You can also show an error message to the user.
                            } else {
                            // Product added to cart successfully.
                            // You can update the UI or show a confirmation message.

                            print('Plant added to recently Viewed.');
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
                                      plant['plantName'],
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
                                              document: addProductToCartMutation,
                                              variables: {
                                                'plantId': plant['id'],
                                                'quantity': quant, // Specify the quantity you want to add to the cart
                                              },
                                            ),
                                          );
                                          if (result.hasException) {
                                            // Handle the error here.
                                            print('Error: ${result.exception.toString()}');
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
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text('Plant added to cart.'),
                                                duration: Duration(seconds: 2), // You can adjust the duration
                                              ),
                                            );
                                          }
                                        } catch (error) {
                                          // Handle any unexpected errors here.
                                          print('Unexpected error: $error');
                                        }
                                      },
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
                                              '₹' + plant['price']
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
                                  left: 12,
                                  top: 135,
                                  child: SizedBox(
                                    width: 111,
                                    height: 22.51,
                                    child: Text(
                                      plant['category'],
                                      style: GoogleFonts.playfairDisplay(
                                        color: Colors.white.withOpacity(
                                            0.7400000095367432),
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
                                        Icons.favorite_outlined,
                                        color: (plantLikedStates[plant['id']] ?? false) ? Colors.red : Colors.grey.withOpacity(0.5),
                                      ),
                                      onPressed: () async {
                                        print('Plant ID: ${plant['id']}');
                                        final isLiked = plantLikedStates[plant['id']] ?? false;

                                        if (!isLiked) {
                                          // Add plant to the wishlist
                                          final result = await client.mutate(
                                            MutationOptions(
                                              document: gql('''
          mutation AddToWishlist(\$plantId: ID!) {
            addPlantsToWishlist(customerId: 1, plantId: \$plantId) {
              savedPlant {
                id
              }
            }
          }
        '''),
                                              variables: {
                                                'plantId': plant['id'],
                                              },
                                            ),
                                          );

                                          if (result.hasException) {
                                            print('Error adding to wishlist: ${result.exception.toString()}');
                                          } else {
                                            setState(() {
                                              // Toggle the liked state in the plantLikedStates map
                                              plantLikedStates[plant['id']] = true;
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  content: Text('Plant added to wishlist successfully.'),
                                                  duration: Duration(seconds: 2),
                                                ),
                                              );
                                            });
                                            print("Added successfully");
                                          }
                                        } else {
                                          // Remove plant from the wishlist
                                          final result = await client.mutate(
                                            MutationOptions(
                                              document: gql('''
          mutation RemoveFromWishlist(\$plantId: ID!) {
            removePlantsFromWishlist(customerId: 1, plantId: \$plantId) {
              deletedCount
            }
          }
        '''),
                                              variables: {
                                                'plantId': plant['id'],
                                              },
                                            ),
                                          );

                                          if (result.hasException) {
                                            print('Error removing from wishlist: ${result.exception.toString()}');
                                          } else {
                                            setState(() {
                                              // Toggle the liked state in the plantLikedStates map
                                              plantLikedStates[plant['id']] = false;
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  content: Text('Plant removed from wishlist successfully.'),
                                                  duration: Duration(seconds: 2),
                                                ),
                                              );
                                            });
                                            print("Removed successfully");
                                          }
                                        }
                                      },
                                      color: Colors.grey,

                                  ),)),
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

                  );
                })));
  }

}


