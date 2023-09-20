
import 'package:flutter/cupertino.dart';
import 'package:graphql/client.dart';

final HttpLink httpLink = HttpLink('http://192.168.1.112:8000/graphql/');

final ValueNotifier<GraphQLClient> client = ValueNotifier(

    GraphQLClient(
      cache: GraphQLCache(),
      link: httpLink,
    )
);