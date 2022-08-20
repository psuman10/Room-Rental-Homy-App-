import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homy_app/app/data/database/homy_database.dart';
import 'package:homy_app/app/data/models/property.dart';
import 'package:homy_app/app/modules/property_details/property_detail_page.dart';

import '../../../core/utils/number_formatter.dart';
import '../../../core/values/colors.dart';

class HouseCard extends StatefulWidget {
  const HouseCard(
      {Key? key, required this.propertyModel, this.isWished = false})
      : super(key: key);

  final PropertyModel propertyModel;
  final bool isWished;

  @override
  State<HouseCard> createState() => _HouseCardState();
}

class _HouseCardState extends State<HouseCard> {
  PropertyModel get _property => widget.propertyModel;

  bool alreadyWished = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      alreadyWished = widget.isWished;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(PropertyDetailPage(
          property: _property,
          isWished: alreadyWished,
        ));
      },
      child: Container(
        width: 150.0,
        decoration: BoxDecoration(color: white, boxShadow: [
          BoxShadow(
            color: hintColor.withOpacity(0.5),
            blurRadius: 2,
            spreadRadius: 2,
            offset: const Offset(0, 3),
          )
        ]),
        margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
        child: Stack(alignment: Alignment.topRight, children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Image.network(
                _property.coverPhotoURL,
                fit: BoxFit.cover,
                width: double.infinity,
              )),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  _property.name,
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.location_pin,
                    size: 12.0,
                    color: primaryBlue,
                  ),
                  Expanded(
                    child: Text(
                      _property.location,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          ?.copyWith(fontSize: 10.0),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Row(
                    //   children: [
                    //     const Icon(
                    //       Icons.star,
                    //       size: 12.0,
                    //       color: yellowColor,
                    //     ),
                    //     Text(
                    //       "2",
                    //       style: Theme.of(context)
                    //           .textTheme
                    //           .headline3
                    //           ?.copyWith(fontSize: 10.0),
                    //     )
                    //   ],
                    // ),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: k_m_b_generator(_property.price),
                          style: Theme.of(context)
                              .textTheme
                              .headline3
                              ?.copyWith(fontSize: 12)),
                      TextSpan(
                          text: "/month",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              ?.copyWith(fontSize: 12)),
                    ]))
                  ],
                ),
              )
            ],
          ),
          GestureDetector(
            onTap: () async {
              if (alreadyWished) {
                final _isRemoved =
                    await HomyDatabase.removeWishList(_property.uuid);
                if (_isRemoved) {
                  setState(() {
                    alreadyWished = false;
                  });
                }
              } else {
                final _isAdded = await HomyDatabase.addToWishList(_property);
                if (_isAdded) {
                  setState(() {
                    alreadyWished = true;
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
                alreadyWished ? Icons.bookmark : Icons.bookmark_outline,
                size: 18.0,
                color: primaryBlue,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
