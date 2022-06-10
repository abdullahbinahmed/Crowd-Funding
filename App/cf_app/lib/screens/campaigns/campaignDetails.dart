import 'package:cf_app/screens/campaigns/model.dart';
import 'package:cf_app/screens/payments/screen.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class CampaignDetails extends StatelessWidget {
  final CampaignEntry campaignEntry;

  const CampaignDetails({Key? key, required this.campaignEntry})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selected Campaign Details'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16.0, right: 16.0),
        child: FloatingActionButton(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => PaymentScreen(
                      campaignEntry: campaignEntry,
                    ),
                fullscreenDialog: false),
          ),
          child: const Icon(Icons.payments_rounded),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.perm_identity),
            title: Text(campaignEntry.name),
            subtitle: const Text('Campaign Name'),
          ),
          ListTile(
            leading: const Icon(Icons.details),
            title: Text(campaignEntry.description),
            subtitle: const Text('Campaign Description'),
          ),
          ListTile(
            leading: const Icon(Icons.date_range),
            title: Text(campaignEntry.startdate
                    .replaceFirst('T', ' ', 0)
                    .replaceFirst('.000Z', ' ') +
                " - " +
                campaignEntry.enddate
                    .replaceFirst('T', ' ', 0)
                    .replaceFirst('.000Z', ' ')),
            subtitle: const Text('Campaign date range '),
          ),
          ListTile(
            leading: const Icon(Icons.start),
            title: Text(campaignEntry.createddate
                .replaceFirst('T', ' ', 0)
                .replaceFirst('.000Z', ' ')),
            subtitle: const Text('Campaign Created date'),
          ),
          ListTile(
            leading: const Icon(
              Icons.attach_money_sharp,
              color: Colors.red,
            ),
            title: Text(campaignEntry.uitargetAmount),
            subtitle: const Text('Target amount'),
          ),
          ListTile(
            leading: const Icon(
              Icons.attach_money_sharp,
              color: Colors.green,
            ),
            title: Text(campaignEntry.uiamountAchieved),
            subtitle: const Text('Acheived Amount'),
          ),
          const SizedBox(
            height: 8.0,
          ),
          const Divider(),
          const SizedBox(
            height: 8.0,
          ),
          ListTile(
            // leading: const Icon(
            //   Icons.attach_money_sharp,
            //   color: Colors.green,
            // ),
            title: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Center(
                  child: LinearPercentIndicator(
                    width: MediaQuery.of(context).size.width - 85,
                    animation: true,
                    lineHeight: 20.0,
                    animationDuration: 2000,
                    percent: (campaignEntry.amountAchieved /
                        campaignEntry.targetAmount),
                    center: Text(((campaignEntry.amountAchieved /
                                    campaignEntry.targetAmount) *
                                100)
                            .toString() +
                        "%"),
                    linearStrokeCap: LinearStrokeCap.roundAll,
                    progressColor: Colors.greenAccent[400],
                  ),
                ),
              ),
            ),
            subtitle: const Center(child: Text('Camapaign progress')),
          ),
        ],
      ),
    );
  }
}
