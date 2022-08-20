import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homy_app/app/core/utils/dialog_utils.dart';
import 'package:homy_app/app/core/utils/extension.dart';
import 'package:homy_app/app/data/models/property.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;

import '../../core/values/colors.dart';
import '../../data/database/homy_database.dart';

class PropertyDetailPage extends StatefulWidget {
  const PropertyDetailPage(
      {Key? key, required this.property, required this.isWished})
      : super(key: key);

  final PropertyModel property;
  final bool isWished;

  @override
  State<PropertyDetailPage> createState() => _PropertyDetailPageState();
}

class _PropertyDetailPageState extends State<PropertyDetailPage> {
  PropertyModel get _property => widget.property;

  bool _isWished = false;

  List<String> bookingsIdList = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      _isWished = widget.isWished;
    });
    getBookingsList();
  }

  void getBookingsList() async {
    final list = await HomyDatabase.getMyBookings();
    List<String> _idList = [];
    for (var element in list) {
      _idList.add(element.uuid);
    }
    setState(() {
      bookingsIdList = _idList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          _topWidget(),
          _propertyDetail(),
          _featureImages(),
          _ownerDetail(),
        ],
      ),
      bottomNavigationBar: _getBookNowWidget(),
    );
  }

  Widget _topWidget() {
    return SizedBox(
      height: 250.0,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                _property.coverPhotoURL,
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    margin: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      color: white,
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      size: 24.0,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    if (_isWished) {
                      final _isRemoved =
                          await HomyDatabase.removeWishList(_property.uuid);
                      if (_isRemoved) {
                        setState(() {
                          _isWished = false;
                        });
                      }
                    } else {
                      final _isAdded =
                          await HomyDatabase.addToWishList(_property);
                      if (_isAdded) {
                        setState(() {
                          _isWished = true;
                        });
                      }
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      color: white,
                    ),
                    child: Icon(
                      _isWished ? Icons.bookmark : Icons.bookmark_outline,
                      size: 24.0,
                      color: primaryBlue,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _propertyDetail() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _property.name,
            style: Theme.of(context).textTheme.headline5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              _property.description,
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    color: textColor.withOpacity(0.7),
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _featureImages() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Feature Images",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Wrap(
            children: [
              ...List.generate(
                _property.featureImages.length,
                (index) => GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) {
                        return Dialog(
                          child: Image.network(
                            _property.featureImages[index],
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    height: 90.0,
                    width: 70.0,
                    margin: const EdgeInsets.all(5.0),
                    child: Image.network(_property.featureImages[index],
                        fit: BoxFit.cover),
                  ),
                ),
              ).toList()
            ],
          ),
        ],
      ),
    );
  }

  Widget _ownerDetail() {
    return GestureDetector(
      onTap: () {
        urlLauncher.launch("tel://${_property.ownerPhoneNumber}");
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 12.0),
        color: primaryBlue,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Owner",
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        ?.copyWith(color: white),
                  ),
                  Text(
                    _property.ownerName,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        ?.copyWith(color: white),
                  ),
                ],
              ),
              Container(
                  margin: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    color: white,
                  ),
                  child: const Icon(
                    Icons.call,
                    size: 18.0,
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget _getBookNowWidget() {
    return Container(
      height: 50.0,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Price",
              style: Theme.of(context).textTheme.headline3,
            ),
            RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: _property.price.toString(),
                    style: Theme.of(context).textTheme.headline5),
                TextSpan(
                    text: "/month", style: Theme.of(context).textTheme.caption),
              ]),
            )
          ],
        ),
        SizedBox(
          width: 150.0,
          child: bookingsIdList.getIsPropertyIsBooked(_property.uuid)
              ? Text(
                  "Already Booked",
                  style: Theme.of(context).textTheme.headline4,
                )
              : ElevatedButton(
                  onPressed: () {
                    DialogUtils.showAdvancePaymentDialog(context, _property);
                  },
                  child: const Text("Book Now"),
                ),
        )
      ]),
    );
  }
}
