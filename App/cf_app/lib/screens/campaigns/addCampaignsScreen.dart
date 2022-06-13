import 'package:cf_app/custom_alert.dart';
import 'package:cf_app/global.dart';
import 'package:cf_app/screens/campaigns/model.dart';
import 'package:flutter/material.dart';

class AddCampaignScreen extends StatefulWidget {
  const AddCampaignScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddCampaignScreenState();
}

class _AddCampaignScreenState extends State<AddCampaignScreen> {
  final GlobalKey<FormState> submitForm = GlobalKey<FormState>();
  final FocusNode nameFocusNode = FocusNode();
  final TextEditingController nameController = TextEditingController();
  final FocusNode descriptionFocusNode = FocusNode();
  final TextEditingController descriptionController = TextEditingController();
  final FocusNode amountFocusNode = FocusNode();
  final TextEditingController amountController = TextEditingController();
  final FocusNode startDateFocusNode = FocusNode();
  final TextEditingController startDateController = TextEditingController();
  final FocusNode endDateFocusNode = FocusNode();
  final TextEditingController endDateController = TextEditingController();
  String? selectedValue = 'Fixed';
  bool isSlectedDD = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Campaign'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: buildCamapignFormView(context),
      ),
    );
  }

  SingleChildScrollView buildCamapignFormView(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Form(
            key: submitForm,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Describe your new Campaign',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Theme.of(context).primaryColor),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Container(
                  margin: const EdgeInsets.all(10.0),
                  child: ClipRect(
                    /** Banner Widget **/
                    child: Container(
                      color: Colors.purple[50],
                      height: 65,
                      width: MediaQuery.of(context).size.width - 15,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.warning,
                                  color: Colors.red,
                                ),
                                const Text(
                                    'Our platform charges a three percent (3%) platform fee '),
                              ],
                            ),
                          ),
                          Text('on all funds raised for your campaign'),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                              child: GestureDetector(
                                child: const Text("Click here for more info.",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Colors.blue)),
                                onTap: () async {},
                              )),
                        ],
                      ), //Padding
                    ), //Banner
                  ), //ClipRect
                ), //container

                const SizedBox(
                  height: 32.0,
                ),
                TextFormField(
                  controller: nameController,
                  focusNode: nameFocusNode,
                  decoration: const InputDecoration(labelText: ' Name'),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  controller: descriptionController,
                  focusNode: descriptionFocusNode,
                  decoration: const InputDecoration(
                      labelText: 'Description',
                      hintText: 'Enter campaign description'),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  controller: amountController,
                  focusNode: amountFocusNode,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: 'Target amount', hintText: 'Target amount'),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  controller: startDateController,
                  focusNode: startDateFocusNode,
                  keyboardType: TextInputType.datetime,
                  decoration: const InputDecoration(
                      labelText: 'Start date', hintText: 'Select start date'),
                  onTap: () async {
                    DateTime? date = DateTime(1900);
                    FocusScope.of(context).requestFocus(new FocusNode());

                    date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100));

                    startDateController.text = date!.toIso8601String();
                  },
                ),
                const SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  controller: endDateController,
                  focusNode: endDateFocusNode,
                  keyboardType: TextInputType.datetime,
                  decoration: const InputDecoration(
                      labelText: 'End date', hintText: 'Select end date'),
                  onTap: () async {
                    DateTime? date = DateTime(1900);
                    FocusScope.of(context).requestFocus(new FocusNode());

                    date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100));

                    endDateController.text = date!.toIso8601String();
                  },
                ),
                const SizedBox(
                  height: 16.0,
                ),
                ListTile(
                  subtitle: Text('Select Funding Type',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.orange, fontSize: 16.0)),
                  title: DropdownButton<String>(
                      isExpanded: true,
                      value: selectedValue,
                      icon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.arrow_circle_down,
                          color: isSlectedDD
                              ? Colors.white
                              : Theme.of(context).highlightColor,
                        ),
                      ),
                      iconSize: 20,
                      elevation: 16,
                      underline: Container(),
                      onChanged: (String? newValue) {
                        setState(() {
                          isSlectedDD = true;
                          selectedValue = newValue;
                        });
                      },
                      items: <String>["Flexible", "Fixed"]
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                            value: value,
                            child: Container(
                              color: isSlectedDD
                                  ? Theme.of(context).primaryColor
                                  : Colors.white,
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(value.toString(),
                                      style: TextStyle(
                                        color: isSlectedDD
                                            ? Colors.white
                                            : Colors.black,
                                      ))),
                            ));
                      }).toList()),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Center(
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ButtonStyle(backgroundColor:
                              MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed)) {
                                return const Color.fromARGB(255, 110, 10, 126)
                                    .withOpacity(0.5);
                              }
                              return const Color.fromARGB(255, 110, 10,
                                  126); // Use the component's default.
                            },
                          )),
                          child: const Text('Submit'),
                          onPressed: addCampaign,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addCampaign() async {
    try {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => const AlertDialog(
          content: ListTile(
            leading: CircularProgressIndicator(),
            title: Text('Processing Request ...'),
          ),
        ),
      );

      CampaignApi api = CampaignApi(dataSource, "token");
      String responseMessage = await api.addCampaign(
          descriptionController.text,
          endDateController.text,
          "",
          nameController.text,
          startDateController.text,
          amountController.text,
          selectedValue ?? "Flexible");

      Navigator.of(context).pop();
      await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => CustomAlert(
            alertStatus: AlertStatus.success, message: responseMessage),
      );
      Navigator.pop(context);
    } catch (exception) {
      await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) =>
            CustomAlert(alertStatus: AlertStatus.error, message: '$exception'),
      );
      Navigator.of(context).pop();
    }
  }
}
