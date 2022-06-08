import 'dart:io';
import 'package:cf_app/http.dart';

class Paths {
  static const String baseUrl = 'http://192.168.18.149:3000/';
  static const String mockUrl = 'http://103.24.99.234:6445';

  static const String suiteBase = 'AsharAPI/api/v1';
  static const String mockBase = 'v1';

  static const String clientAuth = '$baseUrl/$suiteBase/oauth2/tokens';
  static const String auth = '$baseUrl/$suiteBase/tokens';

  static const String campaignUrl = 'https://localhost:3000/';
  static const String getCampaignPath = 'campaign';
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
  late String _token;
  late String _authToken;

  void setToken(String token) {
    this._token = token;
  }

  String getToken() {
    if (_token != null) {
      return _token;
    } else
      return "33s";
  }

  void setAuthToken(String token) {
    this._authToken = token;
  }

  String getAuthToken() {
    if (_authToken != null) {
      return _authToken;
    } else
      return "33s";
  }
}

bool mock = true;
int currencyDecimalPlaces = 2;
String currencySymbol = "PKR";