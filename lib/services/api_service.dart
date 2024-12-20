import 'package:http/http.dart' as http;
import 'dart:convert';


class ApiService {

  final String baseUrl;

  // Constructor
  ApiService({required this.baseUrl});

  Future<dynamic> request({
    required String endpoint,
    required String method,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    dynamic body,
  }) async {

    final Uri url = Uri.parse('$baseUrl$endpoint').replace(queryParameters: queryParameters);


    final defaultHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    final requestHeaders = headers != null
        ? {...defaultHeaders, ...headers}
        : defaultHeaders;


    print('Making $method request to: $url');
    print('Headers: $requestHeaders');
    if (body != null) print('Body: $body');

    try {

      http.Response response;
      switch (method.toUpperCase()) {
        case 'GET':
          response = await http.get(url, headers: requestHeaders);
          print("hello down ");
          break;
        case 'POST':
          response = await http.post(
            url,
            headers: requestHeaders,
            body: jsonEncode(body),
          );
          break;
        case 'PUT':
          response = await http.put(
            url,
            headers: requestHeaders,
            body: jsonEncode(body),
          );
          break;
        case 'DELETE':
          response = await http.delete(
            url,
            headers: requestHeaders,
            body: jsonEncode(body),
          );
          break;
        default:
          throw Exception('Unsupported HTTP method: $method');
      }

      // Check if the response status is successful (200-299)
      if (response.statusCode >= 200 && response.statusCode < 300) {
        // Parse the response body if it's JSON
        return jsonDecode(response.body);
      } else {
        // Handle errors
        throw Exception('Request failed: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      // Handle network errors or unexpected exceptions
      throw Exception('Error during request: $e');
    }
  }
}
