import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql/client.dart';
import 'package:plantbackend/screens/payment.dart';

import '../graphql_client.dart';

class Checkout extends StatefulWidget {
  //const Checkout({Key? key}) : super(key: key);
  final int totalBagTotal;
  final int totalShippingCost;
  final int totalItemTotal;

  Checkout({
    required this.totalBagTotal,
    required this.totalShippingCost,
    required this.totalItemTotal,
  });
  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  Future<void> createUser() async {
    final String createUserMutation = '''
    mutation createCustomer(
    \$fullName: String!
    \$address: String!
    \$city: String!
    \$state: String!
    \$zipCode: String!
    \$country: String!
    \$phone: String!
  ) {
    createCustomer(
      fullName: \$fullName
      address: \$address
      city: \$city
      state: \$state
      zipCode: \$zipCode
      country: \$country
      phone: \$phone
    ) {
      customer {
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
  }

      ''';
    final Map<String, dynamic> variables = {
      'fullName': fullNameController.text,
      'address': addressController.text,
      'city': cityController.text,
      'state': stateController.text,
      'zipCode': zipCodeController.text,
      'country': countryController.text,
      'phone': phoneNumberController.text,
    };
    print('Phone Number: ${phoneNumberController.text}');

    final GraphQLClient _client = client.value;

    final MutationOptions options = MutationOptions(
      document: gql(createUserMutation),
      variables: variables,
    );

    final QueryResult result = await _client.mutate(options);
    print('Mutation Variables: $variables');
    if (result.hasException) {
      // Print the entire GraphQL response for debugging purposes
      print('GraphQL Response: ${result.data.toString()}');

      // Print the exception details
      print('Error creating user: ${result.exception.toString()}');
    } else if (result.data != null) {
      // Print the successful response
      print('User created successfully: ${result.data.toString()}');
    } else {
      // Handle unexpected case
      print('Unexpected result: ${result.toString()}');
    }
  }

  bool isAddressConfirmed = false;
  void confirmAddress() {
    setState(() {
      isAddressConfirmed = true;
    });
  }

  bool allFieldsFilled = false;
  void updateAllFieldsFilled() {
    setState(() {
      allFieldsFilled = fullNameController.text.isNotEmpty &&
          addressController.text.isNotEmpty &&
          cityController.text.isNotEmpty &&
          stateController.text.isNotEmpty &&
          zipCodeController.text.isNotEmpty &&
          countryController.text.isNotEmpty &&
          phoneNumberController.text.isNotEmpty;
    });
  }

  void showAlertDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
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
            "Shipping Details",
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: fullNameController,
                  onChanged: (value) {
                    updateAllFieldsFilled();
                  },
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.green.shade900, width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.green.shade900, width: 2.0),
                    ),
                    filled: true,
                    fillColor: Color(0xFF3C593B)
                        .withOpacity(0.1), // Set the background color here
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: TextField(
                    controller: addressController,
                    onChanged: (value) {
                      updateAllFieldsFilled();
                    },
                    decoration: InputDecoration(
                      labelText: 'Address',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.green.shade900, width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.green.shade900, width: 2.0),
                      ),
                      filled: true,
                      fillColor: Color(0xFF3C593B)
                          .withOpacity(0.1), // Set the background color here
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: cityController,
                  onChanged: (value) {
                    updateAllFieldsFilled();
                  },
                  decoration: InputDecoration(
                    labelText: 'city',
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.green.shade900, width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.green.shade900, width: 2.0),
                    ),
                    filled: true,
                    fillColor: Color(0xFF3C593B)
                        .withOpacity(0.1), // Set the background color here
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: stateController,
                  onChanged: (value) {
                    updateAllFieldsFilled();
                  },
                  decoration: InputDecoration(
                    labelText: 'state',
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.green.shade900, width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.green.shade900, width: 2.0),
                    ),
                    filled: true,
                    fillColor: Color(0xFF3C593B)
                        .withOpacity(0.1), // Set the background color here
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: zipCodeController,
                  onChanged: (value) {
                    updateAllFieldsFilled();
                  },
                  decoration: InputDecoration(
                    labelText: 'zip code',
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.green.shade900, width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.green.shade900, width: 2.0),
                    ),
                    filled: true,
                    fillColor: Color(0xFF3C593B)
                        .withOpacity(0.1), // Set the background color here
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: countryController,
                  onChanged: (value) {
                    updateAllFieldsFilled();
                  },
                  decoration: InputDecoration(
                    labelText: 'country',
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.green.shade900, width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.green.shade900, width: 2.0),
                    ),
                    filled: true,
                    fillColor: Color(0xFF3C593B)
                        .withOpacity(0.1), // Set the background color here
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: phoneNumberController,
                  onChanged: (value) {
                    updateAllFieldsFilled();
                  },
                  decoration: InputDecoration(
                    labelText: 'phone number',
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.green.shade900, width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.green.shade900, width: 2.0),
                    ),
                    filled: true,
                    fillColor: Color(0xFF3C593B)
                        .withOpacity(0.1), // Set the background color here
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 15,
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    // Check if all fields are filled
                    if (fullNameController.text.isEmpty ||
                        addressController.text.isEmpty ||
                        cityController.text.isEmpty ||
                        stateController.text.isEmpty ||
                        zipCodeController.text.isEmpty ||
                        countryController.text.isEmpty ||
                        phoneNumberController.text.isEmpty) {
                      showAlertDialog(context, 'Please fill in all fields.');
                    } else {
                      // All fields are filled, proceed with creating the user
                      createUser();

                      // Then, confirm the address and update the visibility of the "Proceed to Pay" button
                      confirmAddress();
                      updateAllFieldsFilled();
                    }
                  },
                  child: Text(
                    'Confirm address',
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
                      alignment: Alignment.center),
                ),
                Visibility(
                  visible: isAddressConfirmed,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Payment(
                              totalBagTotal:
                                  widget.totalBagTotal, // Corrected here
                              totalShippingCost:
                                  widget.totalShippingCost, // Corrected here
                              totalItemTotal: widget.totalItemTotal,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        'Proceed to pay',
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
                          alignment: Alignment.center)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
