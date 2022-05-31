// @dart=2.10
import 'dart:convert';
import 'dart:io';

import 'global.dart';

const bool _allowSelfSignedCertificates = true;

class HttpClientFactory {
  static HttpClient createClient(
      [bool allowSelfSignedCertificates = _allowSelfSignedCertificates]) {
    var client = HttpClient();
    if (allowSelfSignedCertificates) {
      client.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
    }
    return client;
  }
}

class HttpDataSource {
  HttpDataSource() {
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
  }

  Future<Map> get(String entity,
      //      {String? id, String? token, Map<String, String>? queryParameters})
      {String id,
      String token,
      Map<String, String> queryParameters}) async {
    String uriWithId = '$entity${id == null ? '' : '/$id'}';
    String query = _buildQuery(queryParameters);
    Uri uri = Uri.parse('$uriWithId${query.length > 0 ? '?$query' : ''}');

    print(uri.toString());

    var request = await client.getUrl(uri);

    if (token != null) {
      request.headers.add(HttpHeaders.authorizationHeader, 'Bearer $token');
    }

    var response = await request.close();
    print(response.statusCode);

    Map responseMap = await _extractJson(response);
    _checkAndThrowError(response, responseMap);
    return responseMap;
  }

  Future<Map> post(
    String path, {
    String token,
    dynamic body,
    bool parseResponse: false,
    isFormData: false,
    isUseBaseURL: false,
    isEncoded: false,
  }) async {
    Uri uri;
    uri =
        isUseBaseURL ? Uri.parse('${Paths.baseUrl}/$path') : Uri.parse('$path');

    print(uri.toString());
    print(body.toString());
    print(json.encode(body));

    var request =
        await client.postUrl(uri).timeout(const Duration(seconds: 30));

    if (token != null) {
      request.headers.add(HttpHeaders.authorizationHeader, 'Bearer $token');
    }

    request.headers
        .add("x-consumer-custom-id", TransactionConstants.consumerId);
    request.headers.add("Content-Type", "application/json");

    if (body != null) {
      if (isFormData) {
        request
          ..headers.contentType = ContentType(
              'application', 'x-www-form-urlencoded',
              charset: 'utf-8')
          ..write(body);
      } else {
        request
          ..headers.contentType = ContentType.json
          ..write(isEncoded ? body : json.encode(body));
      }
    }

    print('Closing req stream');
    print(request.headers);
    var response = await request.close();
    print(response);
    print(response.statusCode);
    Map responseMap = await _extractJson(response);
    print(responseMap);
    _checkAndThrowError(response, responseMap);
    return responseMap;
  }

  Future<Map> put(
    String path, {
    String token,
    dynamic body,
    bool parseResponse: false,
    isFormData: false,
    isUseBaseURL: false,
  }) async {
    Uri uri;
    uri =
        isUseBaseURL ? Uri.parse('${Paths.baseUrl}/$path') : Uri.parse('$path');

    print(uri.toString());
    print(body.toString());
    var request = await client.putUrl(uri);

    if (token != null) {
      request.headers.add(HttpHeaders.authorizationHeader, 'Bearer $token');
    }

    if (body != null) {
      if (isFormData) {
        request
          ..headers.contentType = ContentType(
              'application', 'x-www-form-urlencoded',
              charset: 'utf-8')
          ..write(body);
      } else {
        request
          ..headers.contentType = ContentType.json
          ..write(json.encode(body));
      }
    }

    var response = await request.close();

    print(response.statusCode);
    Map responseMap = await _extractJson(response);
    _checkAndThrowError(response, responseMap);
    return responseMap;
  }

  Future getAuthToken(String username, String password) async {
    var req = await client.postUrl(Uri.parse('${Paths.auth}'));
    print(Paths.auth);
    req
      ..headers.contentType = ContentType.json
      ..headers.add(
          HttpHeaders.authorizationHeader, 'Basic ${GlobalConstants.basicAuth}')
      ..write(
        json.encode(
          {
            "username": username,
            "password": password,
            "portalId": GlobalConstants.portalId,
            "grant_type": GlobalConstants.grantTypePassword
          },
        ),
      );

    var response = await req.close();
    print(response.statusCode);

    Map map = await _extractJson(response);
    print(map);
    _checkAndThrowError(response, map);

    var token = map['access_token'];
    authenticator.setAuthToken(token);
    return token;
  }

  Future getToken() async {
    var req = await client.postUrl(Uri.parse('${Paths.clientAuth}'));
    req
      ..headers.contentType = ContentType.json
      ..headers.add(
          HttpHeaders.authorizationHeader, 'Basic ${GlobalConstants.basic}')
      ..write(
        json.encode(
          {"grant_type": GlobalConstants.grantTypeClient},
        ),
      );

    var response = await req.close();
    print(response.statusCode);

    Map map = await _extractJson(response);
    print(map);
    _checkAndThrowError(response, map);

    var token = map['access_token'];
    authenticator.setToken(token);
    return token;
  }

  Future<Map> _extractJson(HttpClientResponse response) async {
    return await response.transform(utf8.decoder).transform(json.decoder).first;
  }

  String _buildQuery(Map<String, dynamic> queryParameters) {
    String query = '';
    queryParameters?.forEach((key, value) => query += '$key=$value&');

    return query.length > 0 ? query.substring(0, query.length - 1) : query;
  }

  void _checkAndThrowError(HttpClientResponse response, Map map) {
    if (response.statusCode == HttpStatus.notFound) {
      throw new ResourceNotFoundException(message: 'Data not found');
    } else if (response.statusCode >= 400) {
      if (response.statusCode == 401) throw new UnauthorizedAccessException();

      throw new HttpException(map['status'] +
          "  " +
          map['responseCode'] +
          "   " +
          map["Transactionlogid"]);
    }
  }
}

class UnauthorizedAccessException extends HttpException {
  UnauthorizedAccessException(
      {String message = 'User not allowed to perform this operation'})
      : super(message);

  @override
  String toString() {
    var b = new StringBuffer()
      ..write('UnauthorizedAccessException: ')
      ..write(message);
    return b.toString();
  }
}

class ResourceNotFoundException extends HttpException {
  ResourceNotFoundException({String message = 'Resource not available'})
      : super(message);

  @override
  String toString() {
    var b = new StringBuffer()
      ..write('ResourceNotFoundException: ')
      ..write(message);
    return b.toString();
  }
}
