
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql/client.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:plantbackend/screens/checkout.dart';

class ShoppingCart extends StatefulWidget {
  //const ShoppingCart({Key? key}) : super(key: key);

  final int quant;
  ShoppingCart({required this.quant});
  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  bool productRemoved = false;
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

  final HttpLink httpLink = HttpLink('http://192.168.1.112:8000/graphql/');

  late GraphQLClient client;

  final String fetchProductQuery = r'''
    query {
      userCart {
        id
        plant {
          id
          plantName
          category
          price
          images
          size
        }
        product {
          id
          productName
          price
          images
          size
        }
        quantity
      }
    }
  ''';

  final String removeFromCartMutation = '''
  mutation RemoveFromCart(\$customerId: ID!, \$itemId: ID!, \$itemType: String!) {
  removeFromCart(customerId: \$customerId, itemId: \$itemId, itemType: \$itemType) {
    deletedCount
  }
}

  
''';
  Future<void> removeFromCart(String customerId, String itemId, String itemType) async {
    // ...
    final MutationOptions options = MutationOptions(
      document: gql(removeFromCartMutation),
      variables: {
        'customerId': customerId, // This is where you use the customerId variable
        'itemId': itemId,
        'itemType': itemType,
      },
    );
    // ...

    final QueryResult result = await client.mutate(options);

    if (result.hasException) {
      // Handle the error, e.g., show an error message
      print('Error removing item from cart: ${result.exception.toString()}');
      print(customerId);
    }  else if (result.data?['removeFromCart']['deletedCount'] == 1) {
  // Item was successfully removed from the cart
  print('Item removed from cart successfully.');
  setState(() {
    productRemoved = true;
  });
  print('Item removed from cart successfully.');
  // Show a Snackbar with the success message
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Product removed successfully.'),
      duration: Duration(seconds: 2), // You can adjust the duration
    ),
  );

    } else {
      // Handle unexpected response
      print('Unexpected result: ${result.toString()}');
    }
  }
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
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.lightGreen.shade50,
        appBar: AppBar(
          backgroundColor: Color(0xFF3C593B),
          title: Text(
            "My Shopping Cart",
            style: GoogleFonts.lora(
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: Icon(Icons.arrow_back),
          shadowColor: Color(0xFF2F482D),
        ),
        body: Query(
          options: QueryOptions(
            document: gql(fetchProductQuery),
          ),
          builder: (QueryResult result, {fetchMore, refetch}) {
            if (result.hasException) {
              return Center(
                child: Text(
                  'Error fetching cart items: ${result.exception.toString()}',
                ),
              );
            }

            if (result.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            final List<dynamic> cartItems = result.data?['userCart'];
            print(result.data);
            int totalItemTotal = 0;
            int totalShippingCost = 99;
            int totalBagTotal = 0;

            for (final cartItem in cartItems) {
              final product = cartItem['product'];
              final plant = cartItem['plant'];
              final quantity = cartItem['quantity'];

              // Calculate item total (price * quantity)
              int itemTotal = 0;
              if (product != null) {
                itemTotal = product['price'] * quantity;
              } else if (plant != null) {
                itemTotal = plant['price'] * quantity;
              }

              // Add item total to totalItemTotal
              totalItemTotal += itemTotal;

              // Shipping cost (assuming it's constant for each item)
              if (plant != null) {
                final plantId = plant['id'];
                print(plantId);
                // Use plantId as needed
              }

              if (product != null) {
                final productId = product['id'];
                print(productId);
                // Use productId as needed
              }
            }

// Calculate total bag total (totalItemTotal + totalShippingCost)
            totalBagTotal = totalItemTotal + totalShippingCost;

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                //shrinkWrap: true,
                                padding: EdgeInsets.only(top: 20,bottom: 40),
                                itemCount: cartItems.length,
                                itemBuilder: (context, index) {
                                  final cartItem = cartItems[index];
                                  final product = cartItem['product'];

                                  final plant = cartItem['plant'];
                                  final quantity = cartItem['quantity'];
                                  String imageUrl;
                                  if (product != null) {
                                    imageUrl = "http://192.168.1.112:8000/media/${product['images']}";
                                  } else if (plant != null) {
                                    imageUrl = "http://192.168.1.112:8000/media/${plant['images']}";
                                  } else {
                                    imageUrl = "null"; // Handle the case where neither product nor plant is available
                                  }
                                  int subtotal = 0;
                                  int shippingCost = 99;
                                  int itemTotal = 0;
                                  // Calculate subtotal based on cart items
                                  for (final cartItem in cartItems) {
                                    final product = cartItem['product'];
                                    final plant = cartItem['plant'];
                                    final quantity = cartItem['quantity'];



                                    // Calculate item total (price * quantity)

                                    if (product != null) {
                                      itemTotal = product['price'] * quantity;
                                    } else if (plant != null) {
                                      itemTotal = plant['price'] * quantity;
                                    }

                                    // Add item total to subtotal
                                    subtotal += itemTotal;
                                  }
                                  // final String itemType = product != null ? 'product' : 'plant';
                                  // final String itemId = product != null ? product['id'] : plant['id'];
                                  // final String customerId="1";

                                  // Calculate bag total (subtotal + shipping cost)
                                  int bagTotal = subtotal + shippingCost;
                                  final double topPosition = index * 100.0;
                                  //final productId=product['id'];


                                  return Container(
                                  width: 329,
                                  height:100.02,
                                  child: Stack(
                                    children: [

                                  Positioned(
                                    left: 0,
                                    top: 0,
                                    child: Container(
                                      width: 329,
                                      height: 91,
                                      decoration: BoxDecoration(color: Colors.transparent),
                                    ),
                                  ),
                                  Positioned(
                                    left: 100,
                                    top: 20,
                                    child: SizedBox(
                                      width: 112,
                                      height: 22,
                                      child:
                                        Text(product != null ? product['productName'] : plant['plantName'],
                                        style: GoogleFonts.playfairDisplay(
                                          color: Colors.black,
                                          fontSize: 18,
                                          //fontFamily: 'Playfair Display',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 100,
                                    top: 40,
                                    child: SizedBox(
                                      width: 63.54,
                                      height: 19.43,
                                      child: Text(
                                        product != null ? product['size'].toString().toLowerCase() : plant['size'].toString().toLowerCase(),
                                        style: GoogleFonts.playfairDisplay(
                                          color: Colors.black.withOpacity(0.6700000166893005),
                                          fontSize: 14,
                                          //fontFamily: 'Playfair Display',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 100,
                                    top: 60,
                                    child: SizedBox(
                                      width: 42.49,
                                      height: 16.02,
                                      child: Row(
                                        children: [
                                          Text("₹",
                                            style: GoogleFonts.acme(
                                              color: Color(0xFF0D0D0D),
                                              fontSize: 15.50,
                                              //fontFamily: 'Acme',
                                              fontWeight: FontWeight.w400,
                                            ),),
                                          Text(product != null ? product['price'].toString() : plant['price'].toString(),
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.acme(
                                              color: Color(0xFF0D0D0D),
                                              fontSize: 15.50,
                                              //fontFamily: 'Acme',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  Positioned(
                                    left: 242,
                                    top: 42,
                                    child: SizedBox(
                                        width: 133,
                                        height: 31.12,
                                        child: Row(
                                          children: [
                                            IconButton(onPressed: (){
                                              decrement();
                                            },
                                              icon: Icon(
                                                  Icons.remove_circle_outline_sharp,
                                                  color: Colors.black,
                                                  size: 20),),

                                            Text(
                                              quantity.toString(),
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontFamily: 'Playfair Display',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),

                                            IconButton(onPressed: (){
                                              increment();
                                            },
                                              icon:Icon(
                                                  Icons.add_circle_outline_sharp,
                                                  color: Colors.black,
                                                  size: 20),),
                                          ],
                                        )
                                    ),
                                  ),
                                  Positioned(
                                    left: 310,
                                    top: 10,
                                    child: SizedBox(
                                      width: 42.49,
                                      height: 16.02,
                                      child: IconButton(
                                        onPressed: () {

                                          if (product != null ||
                                              plant != null) {
                                            final String itemId = product !=
                                                null
                                                ? product['id']
                                                : plant['id'];
                                            print(itemId);
                                            final String itemType = product !=
                                                null ? 'product' : 'plant';
                                            final String customerId="1";
                                            removeFromCart(customerId, itemId,
                                                itemType); // Replace '1' with the actual customer ID
                                          }
                                        },
                                        icon:Icon(Icons.cancel,
                                          size: 20,
                                          color: Colors.black54),
                                    )),
                                  ),
                                  Positioned(
                                    left: 80,
                                    top: 83,
                                    child: Transform(
                                      transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(-3.14),
                                      child: Container(
                                        width: 67,
                                        height: 68,
                                        decoration: ShapeDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment(0.00, -1.00),
                                            end: Alignment(0, 1),
                                            colors: [ Color(0xFF99A897), Color(0xFF99A897)
                                              // ,Color(0xFF50694C),Color(0xFF21411C)],
                                          ]),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(24),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 27,
                                    top: 10.43,
                                    child: Transform(
                                      transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(-0.02),
                                      child:  imageUrl != null
                                          ? Image.network(
                                        imageUrl,
                                        width: 38.26,
                                        height: 70.48,
                                        fit: BoxFit.fill,
                                      )
                                          : Image.asset("assets/category/f1.png",
                                        width: 28.26,
                                        height: 63.48,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),


                                ],
                              ),
                        );


                                },
                              ),
                ),
                Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Row(
                  children: [
                    Text(
                    'Item Total:',
                      style: GoogleFonts.playfairDisplay(
                        color: Color(0xFF0D0D0D),
                        fontSize: 18,
                        //fontFamily: 'Playfair Display',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 180,),
                    Text( '₹$totalItemTotal',
                      style: GoogleFonts.acme(
                        color: Color(0xFF0D0D0D),
                        fontSize: 15,
                        //fontFamily: 'Playfair Display',
                        fontWeight: FontWeight.w400,
                      ),),
                  ],
                ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: 318,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 0.50,
                          //strokeAlign: BorderSide.strokeAlignCenter,
                          color: Color(0x380D0D0D),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                Row(
                  children: [
                    Text(
                    'Shipping Cost:',
                      style: GoogleFonts.playfairDisplay(
                        color: Color(0xFF0D0D0D),
                        fontSize: 18,
                        //fontFamily: 'Playfair Display',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 150,),
                    Text('₹99',
                      style: GoogleFonts.acme(
                        color: Color(0xFF0D0D0D),
                        fontSize: 15,
                        //fontFamily: 'Playfair Display',
                        fontWeight: FontWeight.w400,
                      ),)
                  ],
                ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: 318,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 0.50,
                          //strokeAlign: BorderSide.strokeAlignCenter,
                          color: Color(0x380D0D0D),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                Row(
                  children: [
                    Text(
                    'Bag Total:',
                      style: GoogleFonts.playfairDisplay(
                        color: Color(0xFF0D0D0D),
                        fontSize: 18,
                        //fontFamily: 'Playfair Display',
                        fontWeight: FontWeight.w600,
                      ),
            ),
                    SizedBox(width: 180,),
                    Text(' ₹$totalBagTotal',
                      style: GoogleFonts.acme(
                        color: Color(0xFF0D0D0D),
                        fontSize: 15,
                        //fontFamily: 'Playfair Display',
                        fontWeight: FontWeight.w400,
                      ),)
                  ],
                ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: 318,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 0.50,
                          //strokeAlign: BorderSide.strokeAlignCenter,
                          color: Color(0x380D0D0D),
                        ),
                      ),
                    ),
                  ),

                 SizedBox(
                   height: 20,
                 ),
                 Row(
                   children: [
                     SizedBox(
                       width: 70,
                     ),
                     ElevatedButton(

                        onPressed: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context)=>Checkout( totalBagTotal: totalBagTotal,
                                totalShippingCost: totalShippingCost,
                                totalItemTotal: totalItemTotal,)));
                        },
                        child: Text(
                          'Checkout',
                          style: GoogleFonts.acme(
                            color: Colors.white.withOpacity(0.8600000143051147),
                            fontSize: 20,
                            //fontFamily: 'Playfair Display',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF3C593B),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),

                          ),
                          fixedSize: Size(185, 35),
                          alignment: Alignment.center
                        ),
                      ),
                   ],
                 ),
                ],
                ),
                ),
              ],
            );   // Your existing layout components here

          },
        ),
      ),
    );
  }
}

