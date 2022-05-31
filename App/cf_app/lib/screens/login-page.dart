import 'package:flutter/material.dart';
import '../palatte.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/background-image.dart';
import '../widgets/password-input.dart';
import '../widgets/rounded-button.dart';
import '../widgets/text_input.dart';
import 'campaigns/screen.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BackgroundImage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  // ignore: sized_box_for_whitespace
                  Container(
                    height: 150,
                    child: const Center(
                      child: Text(
                        'Crowdfunding App',
                        style: kHeading,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: const [
                            TextInput(
                              icon: FontAwesomeIcons.solidEnvelope,
                              hint: 'UserId',
                              inputType: TextInputType.text,
                              inputAction: TextInputAction.next,
                            ),
                            PasswordInput(
                              icon: FontAwesomeIcons.lock,
                              hint: 'Password',
                              inputAction: TextInputAction.done,
                            ),
                            Text(
                              'Forgot Password?',
                              style: kBodyText,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 100,
                            ),
                            TextButton(
                                child: const Text('Login'),
                                onPressed: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CampaignListing(),
                                          fullscreenDialog: false),
                                    )),
                            const SizedBox(
                              height: 80,
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                  border: Border(
                                bottom:
                                    BorderSide(color: Colors.white, width: 1),
                              )),
                              child: const Text(
                                'CreateNewAccount',
                                style: kBodyText,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
