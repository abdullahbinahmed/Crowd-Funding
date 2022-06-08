import 'package:flutter/material.dart';

class AddCampaignScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddCampaignScreenState();
}

class _AddCampaignScreenState extends State<AddCampaignScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Campaign'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Container(),
      ),
    );
  }
}
