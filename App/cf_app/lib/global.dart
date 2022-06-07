// @dart=2.10
import 'dart:io';
import 'package:cf_app/http.dart';

class Paths {
  static const String baseUrl = 'https://192.168.4.150:8443';
  static const String mockUrl = 'http://103.24.99.234:6445';

  static const String suiteBase = 'AsharAPI/api/v1';
  static const String mockBase = 'v1';

  static const String clientAuth = '$baseUrl/$suiteBase/oauth2/tokens';
  static const String auth = '$baseUrl/$suiteBase/tokens';
}

final HttpClient client = HttpClient();

final Authenticator authenticator = Authenticator();
final HttpDataSource dataSource = HttpDataSource();

class GlobalConstants {
  static const String basic = 'TUJIOnRwc3Rwcw==';
  static const String basicAuth = 'TWFzdGVyOnRwc3Rwcw==';
  static const String portalId = '7';
  static const String grantTypeClient = 'client_credentials';
  static const String grantTypePassword = 'password';
}

abstract class TransactionConstants {
  static const String accInstCode = '111111';
  static const String transactionCurrency = '586';
  static const String currencyMnemonic = 'PKR';
  static const String refundTransactionCode = '20';
  static const String accountTypeCode = '20';
  static const String operationIdLinkAccount = '77';
  static const String operationId = 'P1';
  static const String operationType = '1';
  static const String customerType = '00';
  static const String relationshipId = '4210173469355';
  static const String consumerId = "400";
}

class Authenticator {
  String _token;
  String _authToken;

  void setToken(String token) {
    this._token = token;
  }

  String getToken() {
    if (_token != null) {
      return _token;
    } else
      return null;
  }

  void setAuthToken(String token) {
    this._authToken = token;
  }

  String getAuthToken() {
    if (_authToken != null) {
      return _authToken;
    } else
      return null;
  }
}

bool mock = true;
int currencyDecimalPlaces = 2;
String currencySymbol = "PKR";
const String logInRoute = 'http://192.168.34.11:3000/auth/google';
const String signUpEndpoint = 'http://192.168.34.11:3000/signup';
