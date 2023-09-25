import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql/client.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../graphql_client.dart';

class Address extends StatefulWidget {
  // const Address({Key? key}) : super(key: key);

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  late GraphQLClient client;

  final String fetchCustomer = """
    query{
    allCustomers{
    id
    fullName
    address
    city
    state
    zipCode
    country
    phone
  }
}
    """;
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
          "My Address",
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
      body: Query(
          options: QueryOptions(
            document: gql(fetchCustomer),
            //place with the actual plant ID
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

            final List<dynamic> customers = result.data?['allCustomers'];
            print(result);
            return ListView.builder(
              padding:
                  EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 20),
              scrollDirection: Axis.vertical,
              itemCount: customers.length,
              itemBuilder: (context, index) {
                final customer = customers[index];

                return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Container(
                      height: 300,
                      padding: EdgeInsets.only(left: 10, right: 20),
                      decoration: BoxDecoration(
                          color: Color(0xFF3C593B).withOpacity(0.2),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Address " + customer['id'],
                            style: GoogleFonts.playfairDisplay(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            customer['fullName'],
                            style: GoogleFonts.playfairDisplay(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            customer['address'],
                            style: GoogleFonts.playfairDisplay(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            customer['city'],
                            style: GoogleFonts.playfairDisplay(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            customer['state'],
                            style: GoogleFonts.playfairDisplay(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            customer['country'],
                            style: GoogleFonts.playfairDisplay(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            customer['zipCode'],
                            style: GoogleFonts.playfairDisplay(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.left,
                          ), // Corrected the field name
                          Text(
                            customer['country'],
                            style: GoogleFonts.playfairDisplay(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            customer['phone'],
                            style: GoogleFonts.playfairDisplay(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ));
              },
            );
          }),
    ));
  }
}
