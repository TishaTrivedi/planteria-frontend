import 'package:flutter/cupertino.dart';
import 'package:graphql/client.dart';

// Tisha
final HttpLink httpLink = HttpLink('http://192.168.1.112:8000/graphql/');
final httpLinkImage = 'http://192.168.1.112:8000/media/';

// Kush
// final HttpLink httpLink = HttpLink('http://192.168.143.104:8000/graphql/');
// final httpLinkImage = 'http://192.168.143.104:8000/media/';

// Kush - P
// Kush
// final HttpLink httpLink = HttpLink('http://192.168.0.126:8000/graphql/');
// final httpLinkImage = 'http://192.168.0.126:8000/media/';

final ValueNotifier<GraphQLClient> client = ValueNotifier(GraphQLClient(
  cache: GraphQLCache(),
  link: httpLink,
));
