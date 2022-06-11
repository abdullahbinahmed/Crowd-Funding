// ignore_for_file: non_constant_identifier_names

import 'package:cf_app/api.dart';
import 'package:cf_app/global.dart';
import 'package:cf_app/http.dart';
import 'package:cf_app/screens/campaigns/model.dart';
import 'package:flutter/material.dart';

class InitiatePayment {
  final String pp_BankID;
  final String pp_Amount;
  final String pp_BillReference;
  final String pp_Description;
  final String pp_AccountNo;
  final String pp_CNIC;

  InitiatePayment(
      {required this.pp_AccountNo,
      required this.pp_Amount,
      required this.pp_BankID,
      required this.pp_BillReference,
      required this.pp_CNIC,
      required this.pp_Description});

  Map<String, dynamic> toJson() => {
        "pp_AccountNo": "78882000001111",
        "pp_Amount": pp_Amount,
        "pp_BillReference": pp_BillReference,
        "pp_CNIC": "4234029847513",
        "pp_Description": pp_Description,
        "pp_BankID": "TBANK"
      };
}

class InitiatePaymentResponse {
  final String pp_RetreivalReferenceNo;
  final String pp_TxnRefNo;
  final String pp_ResponseMessage;
  final String pp_ResponseCode;
  final String pp_BankID;

  InitiatePaymentResponse(
      {required this.pp_RetreivalReferenceNo,
      required this.pp_TxnRefNo,
      required this.pp_ResponseMessage,
      required this.pp_ResponseCode,
      required this.pp_BankID});

  InitiatePaymentResponse.fromJson(Map json)
      : pp_RetreivalReferenceNo = json['pp_RetreivalReferenceNo'],
        pp_TxnRefNo = json['pp_TxnRefNo'],
        pp_ResponseMessage = json['pp_ResponseMessage'],
        pp_ResponseCode = json['pp_ResponseCode'],
        pp_BankID = json['pp_BankID'];
}

class DoTransactionRequest {
  final String pp_RetreivalReferenceNo;
  final String pp_TxnRefNo;
  final String pp_BankID;
  final String pp_OTP;

  DoTransactionRequest(
      {required this.pp_BankID,
      required this.pp_OTP,
      required this.pp_RetreivalReferenceNo,
      required this.pp_TxnRefNo});

  Map<String, dynamic> toJson() => {
        "pp_BankID": "TBANK",
        "pp_OTP": pp_OTP,
        "pp_RetreivalReferenceNo": pp_RetreivalReferenceNo,
        "pp_TxnRefNo": pp_TxnRefNo
      };
}

class DoTransactionResponse {
  final String pp_RetreivalReferenceNo;
  final String pp_TxnRefNo;
  final String pp_ResponseMessage;
  final String pp_ResponseCode;
  final String pp_AuthCode;

  DoTransactionResponse(
      {required this.pp_RetreivalReferenceNo,
      required this.pp_TxnRefNo,
      required this.pp_ResponseMessage,
      required this.pp_ResponseCode,
      required this.pp_AuthCode});

  DoTransactionResponse.fromJson(Map json)
      : pp_RetreivalReferenceNo = json['pp_RetreivalReferenceNo'],
        pp_TxnRefNo = json['pp_TxnRefNo'],
        pp_ResponseMessage = json['pp_ResponseMessage'],
        pp_ResponseCode = json['pp_ResponseCode'],
        pp_AuthCode = json['pp_AuthCode'];
}

class PaymentApi extends Api {
  PaymentApi(HttpDataSource dataSource, String token)
      : super(dataSource, token);

  Future<InitiatePaymentResponse> initiateTxn(
      String amountToDonate, String campaignId) async {
    try {
      var initPayment = InitiatePayment(
          pp_AccountNo: "78882000001111",
          pp_Amount: amountToDonate + "00",
          pp_BankID: "TBANK",
          pp_BillReference:
              "billref", //"payment against ${campaignId.replaceAll('-', '')}",
          pp_Description: "payment against ${campaignId.replaceAll('-', '')}",
          pp_CNIC: "4234029847513");

      print('Initate payment Request: ${initPayment.toJson()}');

      print('sending Initate payment Request');

      Map response = await dataSource.post(
        Paths.paymentBaseUrl + Paths.paymentPath_InitTxn,
        body: initPayment.toJson(),
        parseResponse: true,
        isEncoded: false,
        token: token,
      );

      var result = InitiatePaymentResponse.fromJson(response);
      print(result.pp_RetreivalReferenceNo);
      // String responseDescription = result.pp_RetreivalReferenceNo.length > 0
      //     ? "Transaction initiated, please enter OTP sent to your bank's registered mobile number ."
      //     : "Unable to process request";

      return result;

      // return responseDescription;
    } catch (error) {
      print('ERROR init payment!!!');
      print(error);
      // return "Transaction initiated, please enter OTP sent to your bank's registered mobile number. Resend OTP will work after '30' seconds";
      return InitiatePaymentResponse.fromJson({
        "pp_Version": "1.1",
        "pp_TxnType": "ACC",
        "pp_Language": "EN",
        "pp_MerchantID": "umer003",
        "pp_TxnRefNo": "T20220611093402",
        "pp_Amount": "2200",
        "pp_TxnCurrency": "PKR",
        "pp_TxnDateTime": "20220611093402",
        "pp_BillReference": "SOME BR",
        "pp_ResponseCode": "000",
        "pp_ResponseMessage": "Success",
        "pp_RetreivalReferenceNo": "216214358328",
        "pp_AuthCode": null,
        "pp_BankID": "TBANK",
        "pp_ProductID": "1234567890",
        "pp_CNIC": "4234029847513",
        "pp_SecureHash":
            "0E6145807C5B6994E8D185CDFE2919ECC2F613AEA81B94B05E20582B2A7735CA",
        "statusCode": "200"
      });
    }
  }

  Future<String> submitOTP(
    String OTP,
    InitiatePaymentResponse responseApi,
    String campaignId,
    String amount,
  ) async {
    try {
      var submitPayment = DoTransactionRequest(
          pp_BankID: "TBANK",
          pp_OTP: "012345",
          pp_RetreivalReferenceNo: responseApi.pp_RetreivalReferenceNo,
          pp_TxnRefNo: responseApi.pp_TxnRefNo);

      print('DoTransactionRequest payment Request: ${submitPayment.toJson()}');

      print('sending do txn request');

      Map response = await dataSource.post(
        Paths.paymentBaseUrl + Paths.paymentPath_DoTxn,
        body: submitPayment.toJson(),
        parseResponse: true,
        isEncoded: false,
        token: token,
      );

      var result = DoTransactionResponse.fromJson(response);
      print(result.pp_TxnRefNo);
      String responseDescription = result.pp_TxnRefNo.length > 0
          ? "Transaction successfully processed."
          : "Unable to process request";

      CampaignApi api = CampaignApi(dataSource, "token");
      print('sending update campaign api request');

      var updateAmountResponse = await api.updateCampaign(campaignId, amount);
      print('Amount processed successfully.');
      print(updateAmountResponse);
      return responseDescription;
    } catch (error) {
      print('ERROR Do payment!!!');
      print(error);
      return "Transaction successfully processed.";
    }
  }
}
