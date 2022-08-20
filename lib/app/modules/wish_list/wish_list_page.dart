import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homy_app/app/core/utils/dialog_utils.dart';
import 'package:homy_app/app/core/values/colors.dart';
import 'package:homy_app/app/data/database/homy_database.dart';
import 'package:homy_app/app/data/models/property.dart';
import 'package:homy_app/app/modules/property_details/property_detail_page.dart';

class WishListPage extends StatefulWidget {
  const WishListPage({Key? key}) : super(key: key);

  @override
  State<WishListPage> createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  late final Future<List<PropertyModel>>? _wishListFuture;

  @override
  void initState() {
    super.initState();
    _wishListFuture = HomyDatabase.getUserWishList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            "Wish Properties",
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        Expanded(
          child: FutureBuilder<List<PropertyModel>>(
              future: _wishListFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData && snapshot.data != null) {
                    final List<PropertyModel> _properties = snapshot.data!;
                    return _properties.isEmpty
                        ? Container(
                            alignment: Alignment.center,
                            child: Text(
                              "No properties in wish list",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemCount: _properties.length,
                            itemBuilder: (context, index) {
                              final PropertyModel _property =
                                  _properties[index];
                              return GestureDetector(
                                onTap: () {
                                  Get.to(PropertyDetailPage(
                                    property: _property,
                                    isWished: true,
                                  ));
                                },
                                child: Card(
                                  margin: const EdgeInsets.all(12.0),
                                  elevation: 8.0,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Image.network(
                                            _property.coverPhotoURL,
                                            width: 100,
                                            fit: BoxFit.fitHeight,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          child: Container(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              _property.name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5,
                                            ),
                                            Text(
                                              _property.location,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Text(
                                                  "Rs ${_property.price.toString()}/month"),
                                            ),
                                            TextButton.icon(
                                                onPressed: () {
                                                  DialogUtils
                                                      .showAdvancePaymentDialog(
                                                    context,
                                                    _property,
                                                  );
                                                },
                                                icon: const Icon(
                                                  Icons
                                                      .add_shopping_cart_outlined,
                                                  size: 18.0,
                                                  color: primaryBlue,
                                                ),
                                                label: Text(
                                                  "Book Now",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle1
                                                      ?.copyWith(
                                                          color: primaryBlue),
                                                ))
                                          ],
                                        ),
                                      )),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                  } else {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }
                } else {
                  return Container();
                }
              }),
        )
      ],
    );
  }
}
