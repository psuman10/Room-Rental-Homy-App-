import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homy_app/app/data/database/homy_database.dart';

import '../../data/models/property.dart';
import '../property_details/property_detail_page.dart';

class MyBookingsPage extends StatefulWidget {
  const MyBookingsPage({Key? key}) : super(key: key);

  @override
  State<MyBookingsPage> createState() => _MyBookingsPageState();
}

class _MyBookingsPageState extends State<MyBookingsPage> {
  late final Future<List<PropertyModel>>? _myBookingsFuture;

  @override
  void initState() {
    super.initState();
    _myBookingsFuture = HomyDatabase.getMyBookings();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            "My Bookings",
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        Expanded(
          child: FutureBuilder<List<PropertyModel>>(
            future: _myBookingsFuture,
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData && snapshot.data != null) {
                  final List<PropertyModel> _bookings = snapshot.data!;
                  return _bookings.isEmpty
                      ? Container(
                          alignment: Alignment.center,
                          child: Text(
                            "No properties in your bookings",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        )
                      : ListView.builder(
                          itemCount: _bookings.length,
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: ((context, index) {
                            final PropertyModel _property = _bookings[index];
                            return GestureDetector(
                              onTap: () {
                                Get.to(PropertyDetailPage(
                                  property: _property,
                                  isWished: false,
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
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Text(
                                                "Rs ${_property.price.toString()}/month"),
                                          ),
                                        ],
                                      ),
                                    )),
                                  ],
                                ),
                              ),
                            );
                          }),
                        );
                } else {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                }
              }
              return Container();
            }),
          ),
        )
      ],
    );
  }
}
