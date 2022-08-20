import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  final String _aboutText =
      "Homy - Rental Solution is an online Mobile platform which aims to provide required spaces within their choice of place without any burden. Users can get all details about houses,flats and rooms and they can booked these properties according to their choice. This application provides easy user interface and focusses on current problems of renting required spaces. Focusing on the scnario of Kathmandu Valley, An android Mobile application is developed. We hope you enjoy our services as much as we are offering them to you. If you have any questions or suggestions, please don't hesitate to contact us. -Homy App (A Complete Rental Solution)";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "About",
        style: Theme.of(context).textTheme.headline5,
      )),
      body: Container(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            Text(
              _aboutText,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ),
      ),
    );
  }
}
