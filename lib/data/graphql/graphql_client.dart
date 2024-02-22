import 'dart:developer';

import 'package:emr_005/config/app_environment.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../local_storage/local_storage.dart';
import 'graphql_exceptions.dart';

/// GraphQLConfig class provides configuration and methods for interacting with a GraphQL API.
/// It initializes a GraphQL client, performs queries, mutations, and subscriptions,
/// and handles exceptions.
///
/// Usage:
/// - Call initClient before performing any GraphQL operations.
/// - Use performQuery and performMutation for executing queries and mutations.
/// - Use performSubscription for handling GraphQL subscriptions.
/// - Exception handling is done through the graphQLExceptionHandler.
///
/// Note: Ensure to call initClient before making any GraphQL requests.
///
/// Example:
/// ```dart
/// // Initialize GraphQL client
/// GraphQLConfig.initClient();
///
/// // Define a GraphQL query
/// final queryOptions = QueryOptions(
///   document: gql('YOUR_GRAPHQL_QUERY'),
/// );
///
/// // Perform the query
/// final queryResult = await GraphQLConfig.performQuery(queryOptions);
/// print('GraphQL Result: ${queryResult.data}');
/// ```
///
/// Note: Replace 'YOUR_GRAPHQL_QUERY' with your actual GraphQL query.
class GraphQLConfig {
  /// HttpLink for GraphQL requests
  static final HttpLink httpLink = HttpLink(AppEnvironment.baseUrl);

  /// GraphQLClient instance
  static late GraphQLClient? _client;

  /// Private constructor to prevent direct instantiation
  GraphQLConfig._();

  /// Initialize the GraphQL client
  static void initClient() async {
    // Create a link with authentication
    final Link link = AuthLink(
      getToken: () async {
        final accessToken = LocalStorage.accessToken;
        return 'Bearer $accessToken';
      },
    ).concat(httpLink);

    // Initialize the GraphQL client
    _client = GraphQLClient(
      link: link,
      cache: GraphQLCache(),
    );

    log("Client created", name: "GraphQL");
  }

  /// Get the initialized GraphQL client
  static GraphQLClient get _getClient {
    if (_client == null) {
      throw Exception(
          'GraphQL client has not been initialized. Call initClient first.');
    }
    return _client!;
  }

  /// Perform a GraphQL query.
  ///
  /// Example:
  /// ```dart
  /// final queryOptions = QueryOptions(
  ///   document: gql('YOUR_GRAPHQL_QUERY'),
  /// );
  /// final queryResult = await GraphQLConfig.performQuery(queryOptions);
  /// ```
  static Future<QueryResult> performQuery(QueryOptions options) async {
    try {
      final QueryResult result = await _getClient.query(options);

      // Handle exceptions
      if (result.hasException) {
        _graphQLExceptionHandler(result.exception!);
      }

      log((result.data as Map).keys.elementAt(1) ?? "Unknown Query",
          name: 'GraphQL Query');

      return result;
    } catch (e) {
      rethrow;
    }
  }

  /// Perform a GraphQL mutation.
  ///
  /// Example:
  /// ```dart
  /// final mutationOptions = MutationOptions(
  ///   document: gql('YOUR_GRAPHQL_MUTATION'),
  /// );
  /// final mutationResult = await GraphQLConfig.performMutation(mutationOptions);
  /// ```
  static Future<QueryResult> performMutation(MutationOptions options) async {
    try {
      final QueryResult result = await _getClient.mutate(options);

      // Handle exceptions
      if (result.hasException) {
        _graphQLExceptionHandler(result.exception!);
      }

      log((result.data as Map).keys.elementAt(1) ?? "Unknown Mutation",
          name: 'GraphQL Mutation');

      return result;
    } catch (e) {
      rethrow;
    }
  }

  /// Perform a GraphQL subscription.
  ///
  /// Example:
  /// ```dart
  /// final subscriptionOptions = SubscriptionOptions(
  ///   document: gql('YOUR_GRAPHQL_SUBSCRIPTION'),
  /// );
  /// final subscriptionStream = GraphQLConfig.performSubscription(subscriptionOptions);
  /// ```
  static Stream<QueryResult> performSubscription(SubscriptionOptions options) {
    try {
      return _getClient.subscribe(options);
    } on OperationException {
      rethrow;
    }
  }

  /// Handle GraphQL exceptions.
  ///
  /// Example:
  /// ```dart
  /// try {
  ///   // GraphQL operation
  /// } catch (e) {
  ///   GraphQLConfig.graphQLExceptionHandler(e);
  /// }
  /// ```
  static _graphQLExceptionHandler(OperationException exception) {
    log(exception.toString());
    const Map<String, String> strings = {
      'internetConnectionError':
          'Please check your internet connection and try again',
      'serverErrorMessage':
          'Oops! Something went wrong on our end. Please try again later or contact support for assistance.'
    };

    try {
      if (exception.linkException != null) {
        throw FetchDataException(strings['internetConnectionError']!);
      } else {
        if (exception.graphqlErrors.isNotEmpty) {
          final graphQLError = exception.graphqlErrors.first;
          final message = graphQLError.message == "Http Exception"
              ? strings['serverErrorMessage']!
              : graphQLError.message;
          final originalError =
              exception.graphqlErrors.first.extensions?['originalError'];
          log(originalError?.toString() ?? message, name: "GraphQL Exception");

          if (originalError == null) {
            throw FetchDataException(message);
          }
          final originalErrorMessage = originalError['message'] is List
              ? (originalError['message'] as List?)?.first
              : originalError['message'];

          switch (originalError['statusCode'] ?? 0) {
            case 400:
              throw BadRequestException(originalErrorMessage ?? message,
                  originalError['error'], originalError['statusCode']);
            case 401:
              throw UnAuthorizedException(originalErrorMessage ?? message,
                  originalError['error'], originalError['statusCode']);
            case 409:
              throw InternalServerException(
                  strings['serverErrorMessage']!, originalError['statusCode']);
            case 404:
              throw NotFoundException(
                strings['serverErrorMessage']!,
                originalError['statusCode'],
              );
            default:
              throw FetchDataException(message);
          }
        }
      }
    } catch (e) {
      rethrow;
    }
  }
}


// class GraphQLInterceptor extends Link {
//   final Link _innerLink;

//   GraphQLInterceptor(this._innerLink);

//   @override
//   <Stream<Response>> request(Request request, [NextLink? forward]) async {
//     final Response response = await _innerLink.request(request, forward).first;

//     if (response. == 404) {
//       // Handle 404 as an indication of an expired token
//       log('Received 404 response, redirecting user...');
//       // Add your logic to redirect the user or refresh the token
//     }

//     // Return the response
//     return Stream.value(response);
//   }
// }