import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:chats/cores/app_exception/api_exception.dart';
import 'package:chats/cores/services/api_services/base_api_services.dart';
import 'package:http/http.dart' as http;

class ApiServices implements BaseApiServices {
  @override
  Future getApi(url) async {
    try {
      final response = await http.get(Uri.parse(url));
      return returnResponse(response);
    } on TimeoutException {
      throw TimeOutException('The connection has timed out, please try again.');
    } on SocketException {
      throw NoInternetException(
          'No Internet connection, please check your connection.');
    } on HttpException {
      throw ApiError('Unexpected error occurred.');
    } catch (e) {
      throw ApiException('An unknown error occurred: $e');
    }
  }

  @override
  Future postApi(String url, data) async {
    try {
      final headers = {
        'Content-Type': 'application/json',
      };
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(data),
      );

      return returnResponse(response);
    } on TimeoutException {
      throw TimeOutException('The connection has timed out, please try again.');
    } on SocketException {
      throw NoInternetException(
          'No Internet connection, please check your connection.');
    } on HttpException {
      throw ApiError('Unexpected error occurred.');
    } catch (e) {
      throw ApiException('An unknown error occurred: $e');
    }
  }

  @override
  Future patchApi() {
    // TODO: implement patchApi
    throw UnimplementedError();
  }

  @override
  Future putApi() {
    // TODO: implement putApi
    throw UnimplementedError();
  }

  @override
  Future deleteApi() {
    // TODO: implement deleteApi
    throw UnimplementedError();
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body); // OK - Response is successful
      case 201:
        return jsonDecode(
            response.body); // Created - Resource was created successfully
      case 202:
        return jsonDecode(
            response.body); // Accepted - Request accepted for processing
      case 204:
        return null; // No Content - Response is successful but there's no content to return
      case 400:
        throw BadRequestException(response.body.toString()); // Bad Request
      case 401:
        throw UnauthorisedException(
            response.body.toString()); // Unauthorized - Authentication failed
      case 403:
        throw ForbiddenException(response.body
            .toString()); // Forbidden - User is authenticated but doesn't have permission
      case 404:
        throw NotFoundException(response.body
            .toString()); // Not Found - The requested resource doesn't exist
      case 409:
        throw ConflictException(response.body
            .toString()); // Conflict - Request could not be processed due to a conflict
      case 500:
        throw InternalServerException(
            response.body.toString()); // Internal Server Error
      case 502:
        throw BadGatewayException(response.body
            .toString()); // Bad Gateway - Invalid response from an upstream server
      case 503:
        throw ServiceUnavailableException(response.body
            .toString()); // Service Unavailable - Server is not ready to handle the request
      case 504:
        throw GatewayTimeoutException(response.body
            .toString()); // Gateway Timeout - Server took too long to respond
      default:
        throw FetchDataException(
            'Error occurred while communicating with server, StatusCode: ${response.statusCode}');
    }
  }
}
