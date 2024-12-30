// import 'dart:convert';
// import 'package:http/http.dart' as http;

// Future<Map<String, dynamic>> sendChatQuery(String query, bool general) async {
//   String apiUrl = general
//       ? 'http://127.0.0.1:5000/chat_general'
//       : 'http://127.0.0.1:5000/chat'; // Replace with your backend URL
//   print(apiUrl);
//   try {
//     // Build the request body
//     final Map<String, String> requestBody = {
//       'query': query,
//     };

//     // Send the POST request
//     final http.Response response = await http.post(
//       Uri.parse(apiUrl),
//       headers: {
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode(requestBody),
//     );

//     // Check the status code
//     if (response.statusCode == 200) {
//       // Parse and return the JSON response
//       return jsonDecode(response.body);
//     } else {
//       // Handle error response
//       final errorResponse = jsonDecode(response.body);
//       throw Exception(errorResponse['error'] ?? 'An error occurred');
//     }
//   } catch (e) {
//     // Catch and throw exceptions
//     throw Exception('Failed to send request: $e');
//   }
// }
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> sendChatQuery(
    String query, bool general, bool fileUpload) async {
  String apiUrl = fileUpload
      ? 'http://127.0.0.1:5000/chat_with_pdf'
      : general
          ? 'http://127.0.0.1:5000/chat_general'
          : 'http://127.0.0.1:5000/chat'; // Replace with your backend URL

  try {
    // Build the request body
    final Map<String, dynamic> requestBody = {
      'query': query,
    };

    // Send the POST request
    final http.Response response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );

    // Check the status code
    if (response.statusCode == 200) {
      // Parse and return the JSON response
      return jsonDecode(response.body);
    } else {
      // Attempt to parse and handle error response
      try {
        final errorResponse = jsonDecode(response.body);
        throw Exception(errorResponse['error'] ?? 'An error occurred');
      } catch (_) {
        throw Exception('Unexpected response format: ${response.body}');
      }
    }
  } catch (e) {
    // Catch and throw exceptions
    throw Exception('Failed to send request: $e');
  }
}
