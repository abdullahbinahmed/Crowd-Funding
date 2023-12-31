import 'package:cf_app/api.dart';
import 'package:cf_app/global.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:cf_app/http.dart';
import 'package:flutter/material.dart';

class Campaign {
  final String description;
  final String endDate;
  final String name;
  final String amoutAcheived;
  final String targetAmount;
  final String startDate;
  final String imagePath;
  final String userId;
  final String fundingType;
  final String creatorName;

  Campaign(
      {required this.description,
      required this.endDate,
      required this.name,
      this.amoutAcheived = "0",
      required this.targetAmount,
      required this.startDate,
      required this.imagePath,
      required this.userId,
      required this.fundingType,
      required this.creatorName});

  Map<String, dynamic> toJson() => {
        "description": description,
        "endDate": endDate,
        "startDate": startDate,
        "name": name,
        "amoutAcheived": amoutAcheived,
        "targetAmount": targetAmount,
        "imagePath": imagePath,
        "userId": userId,
        "fundingtype": fundingType,
        "creatorname": creatorName
      };
}

class CampaignResponse {
  final int count;
  String description;
  List<CampaignEntry> campaignList;

  CampaignResponse({required this.count})
      : description = "",
        campaignList = [];

  CampaignResponse.fromJson(Map json)
      : count = json["count"],
        description = "",
        campaignList = [];
}

class CampaignEntry {
  final String id;
  final double amountAchieved;
  final double targetAmount;
  final String name;
  final String enddate;
  final String createddate;
  final String startdate;
  final String description;
  final String imagePath;
  final String userId;
  final String uiamountAchieved;
  final String uitargetAmount;
  final String creatorname;
  final String fundingType;
  final String backers;
  final String daysleft;

  CampaignEntry(
      {required this.id,
      required this.targetAmount,
      required this.name,
      required this.amountAchieved,
      required this.enddate,
      required this.createddate,
      required this.startdate,
      required this.description,
      required this.imagePath,
      required this.userId,
      required this.uiamountAchieved,
      required this.uitargetAmount,
      required this.creatorname,
      required this.backers,
      required this.daysleft,
      required this.fundingType});

  CampaignEntry.fromJson(Map json)
      : id = json['id'],
        uitargetAmount =
            'PKR ' + double.parse(json['targetAmount']).toStringAsFixed(2),
        uiamountAchieved =
            'PKR ' + double.parse(json['amountAchieved']).toStringAsFixed(2),
        targetAmount = double.parse(json['targetAmount']),
        amountAchieved = json['amountAchieved'] == null
            ? 0.0
            : double.parse(json['amountAchieved']),
        name = json['name'],
        enddate = json['enddate'],
        createddate = json['createddate'],
        startdate = json['startdate'],
        description = json['description'],
        imagePath = json['imagePath'],
        creatorname = json['creatorname'],
        backers = json['backers'],
        daysleft = json['daysleft'],
        userId = json['userId'],
        fundingType = json['fundingtype'];
}

class CampaignUpdate {
  final String camapaignId;
  final String amount;

  CampaignUpdate({required this.camapaignId, required this.amount});

  CampaignUpdate.fromJson(Map json)
      : camapaignId = json['camapaignId'],
        amount = json['amount'];
}

class CampaignApi extends Api {
  CampaignApi(HttpDataSource dataSource, String token)
      : super(dataSource, token);

  Future<CampaignResponse> getCampaignList() async {
    Map response = await dataSource.get(Paths.baseUrl + Paths.getCampaignPath,
        queryParameters: {'reserved1': "1"}, token: token);

    var fetchCampaignResponse = CampaignResponse.fromJson(response);

    bool isResponse =
        (fetchCampaignResponse != null && fetchCampaignResponse.count > 0)
            ? true
            : false;

    var description = isResponse
        ? "Campaigns successfully fetched."
        : "No campaigns exist at this time";
    fetchCampaignResponse.description = description;

    if (isResponse) {
      List list = response['campaigns'];
      fetchCampaignResponse.campaignList =
          list.map((json) => CampaignEntry.fromJson(json)).toList();
    }
    return fetchCampaignResponse;
  }

  Future<String> addCampaign(
      String description,
      String endDate,
      String imagePath,
      String name,
      String startDate,
      String targetAmount,
      String selectedType) async {
    var newCampaign = Campaign(
        name: name,
        startDate: startDate,
        userId: "sana",
        targetAmount: targetAmount,
        description: description,
        endDate: endDate,
        imagePath: imagePath,
        amoutAcheived: "0",
        fundingType: selectedType,
        creatorName: "sanasz91 | Karachi, Pakistan");

    print('Campaign Request: ${newCampaign.toJson()}');

    Map response = await dataSource.post(
      Paths.baseUrl + Paths.getCampaignPath,
      body: newCampaign.toJson(),
      parseResponse: true,
      isEncoded: false,
      token: token,
    );

    var result = CampaignEntry.fromJson(response);
    print(result.id);
    String responseDescription = result.id.length > 0
        ? "Campaign have been successfully added."
        : "Unable to process request";

    return responseDescription;
  }

  Future<String> updateCampaign(String camapaignId, String amount) async {
    try {
      Map response = await dataSource.put(
        Paths.baseUrl + Paths.getCampaignPath,
        body: {"campaignId": camapaignId, "amount": amount},
        parseResponse: true,
        token: token,
      );

      var result = CampaignUpdate.fromJson(response);
      print(result);
      String responseDescription = result.camapaignId.length > 0
          ? "Campaign have been successfully updated."
          : "Unable to process request";

      return responseDescription;
    } catch (error) {
      print('ERROR Update payment!!!');
      print(error);
      return "Campaign have been successfully updated";
    }
  }
}
