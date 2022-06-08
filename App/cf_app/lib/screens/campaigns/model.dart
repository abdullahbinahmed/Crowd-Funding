import 'package:cf_app/api.dart';
import 'package:cf_app/global.dart';
import 'package:cf_app/http.dart';

class Campaign {
  final String description;
  final String endDate;
  final String name;
  final String amoutAcheived;
  final String targetAmount;
  final String startDate;
  final String imagePath;
  final String userId;

  Campaign(
      {required this.description,
      required this.endDate,
      required this.name,
      this.amoutAcheived = "0",
      required this.targetAmount,
      required this.startDate,
      required this.imagePath,
      required this.userId});

  Map<String, dynamic> toJson() => {
        "description": description,
        "endDate": endDate,
        "name": name,
        "amoutAcheived": amoutAcheived,
        "targetAmount": targetAmount,
        "imagePath": imagePath,
        "userId": userId
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
  final double targetAmount;
  final String name;
  final double amountAchieved;
  final String enddate;
  final String createddate;
  final String startdate;
  final String description;
  final String imagePath;
  final String userId;

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
      required this.userId});

  CampaignEntry.fromJson(Map json)
      : id = json['id'],
        // targetAmount = 'PKR ' + json['targetAmount'].toStringAsFixed(2),
        // amountAchieved = 'PKR ' + json['amountAchieved'].toStringAsFixed(2),
        targetAmount = double.parse(json['targetAmount']),
        amountAchieved = double.parse(json['amountAchieved']),
        name = json['name'],
        enddate = json['enddate'],
        createddate = json['createddate'],
        startdate = json['startdate'],
        description = json['description'],
        imagePath = json['imagePath'],
        userId = json['userId'];
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
      String targetAmount) async {
    var newCampaign = Campaign(
        name: name,
        startDate: startDate,
        userId: "sana",
        targetAmount: targetAmount,
        description: description,
        endDate: endDate,
        imagePath: imagePath,
        amoutAcheived: "0");

    print('Campaign Request: ${newCampaign.toJson()}');

    Map response = await dataSource.post(
      Paths.campaignUrl,
      body: newCampaign.toJson(),
      parseResponse: true,
      token: token,
    );

    var result = CampaignEntry.fromJson(response);

    String responseDescription = result.id != null
        ? "Campaign have been successfully added."
        : "Unable to process request";

    return responseDescription;
  }
}
