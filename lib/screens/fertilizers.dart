import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql/client.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:plantbackend/Animations/slide_animation.dart';

import '../graphql_client.dart';

class Fertilizers extends StatefulWidget {
  //const Fertilizers({Key? key}) : super(key: key);

  late final String plantId;
  Fertilizers({required this.plantId});
  @override
  State<Fertilizers> createState() => _FertilizersState();
}

class _FertilizersState extends State<Fertilizers>
    with SingleTickerProviderStateMixin {
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
  Map<String, bool> plantLikedStates = {};

  final String fetchPlantQuery = r'''
    query($id: ID!) {
      plantsById(id: $id) {
        id
        plantName
        desc
        category
        subcategory
        price
        family
        size
        images
        water
        sunlight
        fertilizer
        temperature
       
        
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
    _tabController = TabController(length: 2, vsync: this);
    quant = 1;
  }

  @override
  void dispose() {
    _tabController.dispose();
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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
        child: Scaffold(
      backgroundColor: Colors.lightGreen.shade50,
      body: Query(
          options: QueryOptions(document: gql(fetchPlantQuery), variables: {
            'id': widget.plantId,
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
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final Map<String, dynamic> plants = result.data?['plantsById'];
            return SingleChildScrollView(
              child: Container(
                width: 371,
                height: 1201,
                color: Colors.lightGreen.shade50,
                child: Stack(
                  children: [
                    Positioned(
                      left: -152,
                      top: -45,
                      child: Container(
                        width: 722,
                        height: 2000,
                        child: Stack(
                          children: [
                            Positioned(
                                left: 180,
                                top: 750,
                                child: Container(
                                  width: 350,
                                  height: 500,
                                  padding: const EdgeInsets.only(right: 40),
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
                              left: 150,
                              top: 370.79,
                              child: SizedBox(
                                width: width,
                                height: 50,
                                child: Text(
                                  plants['plantName'],
                                  style: GoogleFonts.playfairDisplay(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 290.67,
                              top: 425.79,
                              child: SizedBox(
                                width: 270.22,
                                height: 60.03,
                                child: Text(
                                  plants['subcategory'],
                                  style: GoogleFonts.playfairDisplay(
                                    color: Colors.black45,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Container(
                                width: 96.85,
                                height: 97.24,
                                decoration: const BoxDecoration(
                                    color: Color(0xFFD9D9D9)),
                              ),
                            ),
                            Positioned(
                              left: 176.27,
                              top: 298.96,
                              child: SizedBox(
                                width: 120.10,
                                height: 31.12,
                                child: Text(
                                  '₹' + plants['price'].toString(),
                                  style: GoogleFonts.acme(
                                    color: Colors.black
                                        .withOpacity(0.6600000262260437),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 177.24,
                              top: 234.48,
                              child: SizedBox(
                                width: 120.10,
                                height: 31.12,
                                child: Text(
                                  plants['family'],
                                  style: GoogleFonts.acme(
                                    color: Colors.black
                                        .withOpacity(0.6600000262260437),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 178.21,
                              top: 179.33,
                              child: SizedBox(
                                width: 120.10,
                                height: 31.12,
                                child: Text(
                                  plants['size'],
                                  style: GoogleFonts.acme(
                                    color: Colors.black
                                        .withOpacity(0.6600000262260437),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 320.59,
                              top: 89.05,
                              child: SlideAnimation(
                                duration: const Duration(seconds: 1),
                                child: Container(
                                  width: 188.62,
                                  height: 286.84,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          "${httpLinkImage}${plants['images']}"),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 177.24,
                              top: 272.68,
                              child: SizedBox(
                                width: 105.57,
                                height: 41.81,
                                child: Text(
                                  'Price\n',
                                  style: GoogleFonts.playfairDisplay(
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 177.24,
                              top: 206.56,
                              child: SizedBox(
                                width: 105.57,
                                height: 37.92,
                                child: Text(
                                  'Family\n',
                                  style: GoogleFonts.playfairDisplay(
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 177.24,
                              top: 151.41,
                              child: SizedBox(
                                width: 105.57,
                                height: 37.92,
                                child: Text(
                                  'Size',
                                  style: GoogleFonts.playfairDisplay(
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 100,
                              left: 167.24,
                              child: IconButton(
                                icon: Icon(
                                  Icons.favorite_outlined,
                                  color:
                                      (plantLikedStates[plants['id']] ?? false)
                                          ? Colors.red
                                          : Colors.grey.withOpacity(0.5),
                                ),
                                onPressed: () async {
                                  print('Plant ID: ${plants['id']}');
                                  final isLiked =
                                      plantLikedStates[plants['id']] ?? false;

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
                                          'plantId': plants['id'],
                                        },
                                      ),
                                    );

                                    if (result.hasException) {
                                      print(
                                          'Error adding to wishlist: ${result.exception.toString()}');
                                    } else {
                                      setState(() {
                                        // Toggle the liked state in the plantLikedStates map
                                        plantLikedStates[plants['id']] = true;
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                'Plant added to wishlist successfully.'),
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
                                          'plantId': plants['id'],
                                        },
                                      ),
                                    );

                                    if (result.hasException) {
                                      print(
                                          'Error removing from wishlist: ${result.exception.toString()}');
                                    } else {
                                      setState(() {
                                        // Toggle the liked state in the plantLikedStates map
                                        plantLikedStates[plants['id']] = false;
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                'Plant removed from wishlist successfully.'),
                                            duration: Duration(seconds: 2),
                                          ),
                                        );
                                      });
                                      print("Removed successfully");
                                    }
                                  }
                                },
                                // color: Colors.grey,
                              ),
                            ),

                            // TabView
                            Positioned(
                              left: 176,
                              top: 450,
                              right: 0,
                              bottom: 0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  FractionallySizedBox(
                                    widthFactor: 0.5,
                                    child: TabBar(
                                      controller: _tabController,
                                      physics:
                                          const AlwaysScrollableScrollPhysics(),
                                      // padding: EdgeInsets.only(left: 20),
                                      indicatorColor: Colors.black12,
                                      labelStyle:
                                          GoogleFonts.acme(color: Colors.black),
                                      labelColor: Colors.black,
                                      unselectedLabelStyle:
                                          GoogleFonts.acme(color: Colors.black),
                                      unselectedLabelColor: Colors.black,

                                      tabs: [
                                        const Tab(
                                          child: SizedBox(
                                            width:
                                                100, // Expand the width to take half of the space
                                            child: Center(
                                              child: Text(
                                                'Description',
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ),
                                        // Custom layout for the second tab (Plant care)
                                        const Tab(
                                          child: SizedBox(
                                            width:
                                                100, // Expand the width to take half of the space
                                            child: Center(
                                              child: Text(
                                                'Plant care',
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                      labelPadding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 150,
                                    width: 320,
                                    child: Container(
                                      width: 350,
                                      height: 200,
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(24),
                                        ),
                                      ),
                                      child: TabBarView(
                                          controller: _tabController,
                                          children: [
                                            // Description Tab Content
                                            Container(
                                              decoration: ShapeDecoration(
                                                gradient: LinearGradient(
                                                  begin: const Alignment(
                                                      0.00, -1.00),
                                                  end: const Alignment(0, 1),
                                                  colors: [
                                                    const Color(0xFDBBDA9B)
                                                        .withOpacity(0.4),
                                                    const Color(0xFDC8DEAE)
                                                        .withOpacity(0.4),
                                                    const Color(0xFDE1ECD3)
                                                        .withOpacity(0.4)
                                                  ],
                                                ),
                                                // color: Colors.lightGreen[100],
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(24),
                                                ),
                                              ),
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 10, top: 10),
                                              child: Text(
                                                //textAlign: TextAlign.center,
                                                plants['desc'],
                                                style:
                                                    GoogleFonts.playfairDisplay(
                                                  color: Colors.black,
                                                  fontSize: 13,
                                                  // fontFamily: 'Playfair Display',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                            // About Tab Content
                                            SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: 220,
                                                    height: 140,
                                                    child: Stack(
                                                      children: [
                                                        Positioned(
                                                          left: 10,
                                                          top: 7,
                                                          child: Container(
                                                            width: 200,
                                                            height: 130,
                                                            decoration:
                                                                ShapeDecoration(
                                                              gradient:
                                                                  LinearGradient(
                                                                begin:
                                                                    const Alignment(
                                                                        0.00,
                                                                        -1.00),
                                                                end:
                                                                    const Alignment(
                                                                        0, 1),
                                                                colors: [
                                                                  const Color(
                                                                          0xFDEFE73B)
                                                                      .withOpacity(
                                                                          0.5),
                                                                  const Color(
                                                                          0xFFF5E9A3)
                                                                      .withOpacity(
                                                                          0.5),
                                                                ],
                                                              ),
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            24),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          left: 20,
                                                          top: 25,
                                                          child: Container(
                                                            width: 25,
                                                            height: 25,
                                                            child: Icon(
                                                                Icons.sunny,
                                                                color: Colors
                                                                    .orange
                                                                    .shade700),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          left: 20,
                                                          top: 55,
                                                          child: SizedBox(
                                                            width: 200,
                                                            height: 50,
                                                            child: Text(
                                                              'Sunlight ',
                                                              style: GoogleFonts
                                                                  .playfairDisplay(
                                                                color: Colors
                                                                    .black54,
                                                                fontSize: 15,
                                                                //fontFamily: 'Playfair Display',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          left: 20,
                                                          top: 80,
                                                          child: SizedBox(
                                                            width: 200,
                                                            height: 50,
                                                            child: Text(
                                                              plants[
                                                                  'sunlight'],
                                                              style: GoogleFonts
                                                                  .playfairDisplay(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 15,
                                                                //fontFamily: 'Playfair Display',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 220,
                                                    height: 140,
                                                    child: Stack(
                                                      children: [
                                                        Positioned(
                                                          //left:10,
                                                          top: 7,
                                                          child: Container(
                                                            width: 200,
                                                            height: 130,
                                                            decoration:
                                                                ShapeDecoration(
                                                              gradient:
                                                                  LinearGradient(
                                                                begin:
                                                                    const Alignment(
                                                                        0.00,
                                                                        -1.00),
                                                                end:
                                                                    const Alignment(
                                                                        0, 1),
                                                                colors: [
                                                                  const Color(
                                                                          0xFD48B5AF)
                                                                      .withOpacity(
                                                                          0.4),
                                                                  const Color(
                                                                          0xFDA8E8E4)
                                                                      .withOpacity(
                                                                          0.4)
                                                                ],
                                                              ),
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            24),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          left: 20,
                                                          top: 25,
                                                          child: Container(
                                                            width: 25,
                                                            height: 25,
                                                            child: Icon(
                                                                Icons
                                                                    .water_drop,
                                                                color: Colors
                                                                    .blue
                                                                    .shade900),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          left: 20,
                                                          top: 55,
                                                          child: SizedBox(
                                                            width: 200,
                                                            height: 50,
                                                            child: Text(
                                                              'Water ',
                                                              style: GoogleFonts
                                                                  .playfairDisplay(
                                                                color: Colors
                                                                    .black54,
                                                                fontSize: 15,
                                                                //fontFamily: 'Playfair Display',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          left: 20,
                                                          top: 80,
                                                          child: SizedBox(
                                                            width: 200,
                                                            height: 50,
                                                            child: Text(
                                                              plants['water'],
                                                              style: GoogleFonts
                                                                  .playfairDisplay(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 15,
                                                                //fontFamily: 'Playfair Display',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 220,
                                                    height: 140,
                                                    child: Stack(
                                                      children: [
                                                        Positioned(
                                                          left: 10,
                                                          top: 7,
                                                          child: Container(
                                                            width: 200,
                                                            height: 130,
                                                            decoration:
                                                                ShapeDecoration(
                                                              gradient:
                                                                  LinearGradient(
                                                                begin:
                                                                    const Alignment(
                                                                        0.00,
                                                                        -1.00),
                                                                end:
                                                                    const Alignment(
                                                                        0, 1),
                                                                colors: [
                                                                  const Color(
                                                                          0xFDF5890B)
                                                                      .withOpacity(
                                                                          0.3),
                                                                  const Color(
                                                                          0xFFEFAC77)
                                                                      .withOpacity(
                                                                          0.3)
                                                                ],
                                                              ),
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            24),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          left: 20,
                                                          top: 25,
                                                          child: Container(
                                                            width: 25,
                                                            height: 25,
                                                            child: Icon(
                                                                Icons
                                                                    .thermostat_rounded,
                                                                color: Colors
                                                                    .red
                                                                    .shade700),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          left: 20,
                                                          top: 55,
                                                          child: SizedBox(
                                                            width: 200,
                                                            height: 50,
                                                            child: Text(
                                                              'Temperature ',
                                                              style: GoogleFonts
                                                                  .playfairDisplay(
                                                                color: Colors
                                                                    .black54,
                                                                fontSize: 15,
                                                                //fontFamily: 'Playfair Display',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          left: 20,
                                                          top: 80,
                                                          child: SizedBox(
                                                            width: 200,
                                                            height: 50,
                                                            child: Text(
                                                              plants[
                                                                  'temperature'],
                                                              style: GoogleFonts
                                                                  .playfairDisplay(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 15,
                                                                //fontFamily: 'Playfair Display',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 220,
                                                    height: 140,
                                                    child: Stack(
                                                      children: [
                                                        Positioned(
                                                          left: 10,
                                                          top: 7,
                                                          child: Container(
                                                            width: 200,
                                                            height: 130,
                                                            decoration:
                                                                ShapeDecoration(
                                                              gradient:
                                                                  LinearGradient(
                                                                begin:
                                                                    const Alignment(
                                                                        0.00,
                                                                        -1.00),
                                                                end:
                                                                    const Alignment(
                                                                        0, 1),
                                                                colors: [
                                                                  const Color(
                                                                          0xFD8979EC)
                                                                      .withOpacity(
                                                                          0.3),
                                                                  const Color(
                                                                          0xFDBDB3F5)
                                                                      .withOpacity(
                                                                          0.3)
                                                                ],
                                                              ),
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            24),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          left: 20,
                                                          top: 25,
                                                          child: Container(
                                                            width: 25,
                                                            height: 25,
                                                            child: Icon(
                                                                Icons
                                                                    .waves_outlined,
                                                                color: Colors
                                                                    .deepPurple
                                                                    .shade700),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          left: 20,
                                                          top: 55,
                                                          child: SizedBox(
                                                            width: 200,
                                                            height: 50,
                                                            child: Text(
                                                              'Fertilizer',
                                                              style: GoogleFonts
                                                                  .playfairDisplay(
                                                                color: Colors
                                                                    .black54,
                                                                fontSize: 15,
                                                                //fontFamily: 'Playfair Display',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          left: 20,
                                                          top: 75,
                                                          child: SizedBox(
                                                            width: 160,
                                                            height: 70,
                                                            child: Text(
                                                              plants[
                                                                  'fertilizer'],
                                                              style: GoogleFonts
                                                                  .playfairDisplay(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 15,
                                                                //fontFamily: 'Playfair Display',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ]),
                                    ),
                                  )
                                ],
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
                            // Positioned(
                            // left: 178,
                            // top: 828,
                            // child: SizedBox(
                            // width: 293.46,
                            // height:150.37,
                            // child: Text(
                            // "•	The image displayed is indicative in nature.\n•	Actual product may vary in shape or design as per the availability.\n•	The number of leaves and the size of the plant depends on seasonal availability.\n•	Since flowers are seasonal in nature, flowering plants may be delivered without the bloom. Flowers, if present in plant, may be in fully bloomed, semi-bloomed or bud stage.\n•	Pots will be provided as per the requirement of the plant.\n•	Delivery will be attempted on the same day, but there may be a delay of 3-5 hours depending on the traffic and the weather.\n•	Our courier partners do not call prior to delivering an order, so we recommend that you provide an address at which someone will be present to receive the package.\n•	The delivery, once dispatched, cannot be redirected to any other address.",
                            // style: GoogleFonts.playfairDisplay(
                            // color: Colors.black,
                            // fontSize: 13,
                            // // fontFamily: 'Playfair Display',
                            // fontWeight: FontWeight.w400,
                            // ),
                            // ),
                            // ),
                            // ),
                            Positioned(
                              left: 267,
                              top: 685,
                              child: Container(
                                width: 125,
                                height: 29.17,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFF21411C),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 262,
                              top: 682,
                              child: SizedBox(
                                  width: 133,
                                  height: 31.12,
                                  child: Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          decrement();
                                        },
                                        icon: const Icon(
                                            Icons.remove_circle_outline_sharp,
                                            color: Colors.white,
                                            size: 20),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                        '$quant',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontFamily: 'Playfair Display',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          increment();
                                        },
                                        icon: const Icon(
                                            Icons.add_circle_outline_sharp,
                                            color: Colors.white,
                                            size: 20),
                                      ),
                                    ],
                                  )),
                            ),
                            Positioned(
                              left: 423.79,
                              top: 470.35,
                              child: Container(
                                width: 24.21,
                                height: 24.31,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0)),
                              ),
                            ),
                            Positioned(
                              left: 697.79,
                              top: 486.05,
                              child: Container(
                                width: 24.21,
                                height: 24.31,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0)),
                                child:
                                    const Icon(Icons.add_circle_outline_sharp),
                              ),
                            ),
                            Positioned(
                              left: 697.79,
                              top: 486.05,
                              child: Container(
                                width: 24.21,
                                height: 24.31,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0)),
                              ),
                            ),

                            Positioned(
                              left: 240,
                              top: 727.68,
                              child: SizedBox(
                                  width: 180.95,
                                  height: 32.46,
                                  child: ElevatedButton(
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
                                              'plantId': plants['id'],
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
                                          print('Plant added to cart.');
                                        }
                                      } catch (error) {
                                        // Handle any unexpected errors here.
                                        print('Unexpected error: $error');
                                      }
                                    },
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.shopping_cart,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                        const SizedBox(
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
                                      backgroundColor: const Color(0xFF21411C),
                                      minimumSize: const Size(180.77, 40),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                    ),
                                  )),
                            ),
                            // Positioned(
                            // left: 697.79,
                            // top: 506.05,
                            // child: Container(
                            // width: 24.21,
                            // height: 24.31,
                            //
                            // clipBehavior: Clip.antiAlias,
                            // decoration: ShapeDecoration(
                            // color: Color(0xFF21411C),
                            // shape: RoundedRectangleBorder(
                            // borderRadius: BorderRadius.circular(24),
                            // ),
                            // ),)),
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
