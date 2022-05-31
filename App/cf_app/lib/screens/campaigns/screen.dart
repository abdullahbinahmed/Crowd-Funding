import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class CampaignListing extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CampaignListingState();
}

class _CampaignListingState extends State<CampaignListing> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Campaigns'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                elevation: 10.0,
                child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 200,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      NetworkImage("https://picsum.photos/600"),
                                  fit: BoxFit.contain)),
                        ),
                        Divider(),
                        SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Center(
                              child: LinearPercentIndicator(
                                width: MediaQuery.of(context).size.width - 85,
                                animation: true,
                                lineHeight: 20.0,
                                animationDuration: 2000,
                                percent: 0.9,
                                center: Text("90.0%"),
                                linearStrokeCap: LinearStrokeCap.roundAll,
                                progressColor: Colors.greenAccent[400],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                    // child: Column(children: [
                    //   ShaderMask(
                    //       shaderCallback: (bounds) => LinearGradient(
                    //             colors: [Colors.black, Colors.black12],
                    //             begin: Alignment.bottomCenter,
                    //             end: Alignment.center,
                    //           ).createShader(bounds),
                    //       blendMode: BlendMode.darken,
                    //       child: Container(
                    //         decoration: BoxDecoration(
                    //           image: DecorationImage(
                    //             image: AssetImage('assets/images/login_bg.jpg'),
                    //             fit: BoxFit.fill,
                    //             colorFilter: ColorFilter.mode(
                    //                 Colors.black45, BlendMode.darken),
                    //           ),
                    //         ),
                    //       )),
                    //   Text('Heress')
                    // ]),
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
