import 'package:cf_app/global.dart';
import 'package:cf_app/screens/campaigns/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'addCampaignsScreen.dart';
import 'campaignDetails.dart';

class CampaignListing extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CampaignListingState();
}

class _CampaignListingState extends State<CampaignListing> {
  bool isLoading = true;
  CampaignResponse responseCampaigns = CampaignResponse(count: 0);

  @override
  void initState() {
    print('here');
    super.initState();
    fetchCampaigns();
  }

  Future<Null> fetchCampaigns() async {
    try {
      setState(() {
        isLoading = true;
      });

      CampaignApi api = CampaignApi(dataSource, "ssd");
      var response = await api.getCampaignList();

      setState(() {
        responseCampaigns = response;
        isLoading = false;
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    print(isLoading);
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 16.0, right: 16.0),
          child: FloatingActionButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => AddCampaignScreen(),
                  fullscreenDialog: false),
            ),
            child: Icon(Icons.add),
            backgroundColor: Theme.of(context).primaryColor,
          ),
        ),
        appBar: AppBar(
          title: const Text('Campaigns'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: isLoading == true
            ? Center(child: CircularProgressIndicator())
            : responseCampaigns.count > 0
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RefreshIndicator(
                      onRefresh: fetchCampaigns,
                      child: ListView(
                          children: ListTile.divideTiles(
                                  context: context,
                                  color: Theme.of(context).primaryColorLight,
                                  tiles: getCampaignListWidget(
                                      responseCampaigns.campaignList))
                              .toList()),
                    ))
                : const Center(child: Text("Nothing to show")),
      ),
    );
  }

  List<CampaignItemWidget> getCampaignListWidget(
      List<CampaignEntry> transactions) {
    List<CampaignItemWidget> widgetList = <CampaignItemWidget>[];
    for (var item in transactions) {
      widgetList.add(
        CampaignItemWidget(
            campaignDetails: item,
            name: item.name,
            description: item.description,
            amountAcheived: item.amountAchieved,
            totalAmount: item.targetAmount,
            imagePath: item.imagePath),
      );
    }
    return widgetList;
  }
}

class CampaignItemWidget extends StatelessWidget {
  final CampaignEntry campaignDetails;
  final String name;
  final String description;
  final String imagePath;
  final double totalAmount;
  final double amountAcheived;

  CampaignItemWidget(
      {required this.campaignDetails,
      required this.name,
      required this.description,
      required this.imagePath,
      required this.totalAmount,
      required this.amountAcheived});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      elevation: 10.0,
      child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              GestureDetector(
                child: Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(imagePath), fit: BoxFit.contain)),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => CampaignDetails(
                              campaignEntry: campaignDetails,
                            ),
                        fullscreenDialog: false),
                  );
                },
              ),
              Divider(),
              Center(
                  child: Text(
                name,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.black,
                    ),
              )),
              Divider(),
              Center(
                  child: Text(
                description,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 16.0),
              )),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    campaignDetails.backers + " ",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Backers",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.purple),
                  )
                ],
              ),
              SizedBox(
                height: 8.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    campaignDetails.uiamountAchieved,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.green),
                  ),
                  Text(
                    " of ",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.orange),
                  ),
                  Text(
                    campaignDetails.uitargetAmount,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.red),
                  )
                ],
              ),
              SizedBox(
                height: 8.0,
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Center(
                    child: LinearPercentIndicator(
                      width: MediaQuery.of(context).size.width - 85,
                      animation: true,
                      lineHeight: 20.0,
                      animationDuration: 2000,
                      percent: (amountAcheived / totalAmount),
                      center: Text(
                          ((amountAcheived / totalAmount) * 100).toString() +
                              "%"),
                      linearStrokeCap: LinearStrokeCap.roundAll,
                      progressColor: Colors.greenAccent[400],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    campaignDetails.daysleft + " ",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    int.parse(campaignDetails.daysleft) > 1
                        ? "Days Left"
                        : "Day Left!",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.purple),
                  )
                ],
              ),
            ],
          )),
    );
  }
}


      // showDialog(
      //   barrierDismissible: false,
      //   context: context,
      //   builder: (context) => const AlertDialog(
      //     content: ListTile(
      //       leading: CircularProgressIndicator(),
      //       title: Text("Processing ..."),
      //     ),
      //   ),
      // );
