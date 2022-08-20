import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homy_app/app/core/utils/enum.dart';
import 'package:homy_app/app/core/utils/extension.dart';
import 'package:homy_app/app/data/database/homy_database.dart';
import 'package:homy_app/app/data/models/all_property.dart';
import 'package:homy_app/app/data/models/property.dart';
import 'package:homy_app/app/modules/home/properties_page.dart';
import 'package:homy_app/app/modules/home/widgets/house_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final Future<AllProperty>? allPropertyFuture;

  List<String> wishPropertyIdList = [];

  @override
  void initState() {
    super.initState();
    allPropertyFuture = HomyDatabase.getHomePageProperties();
    getWishList();
  }

  getWishList() async {
    final list = await HomyDatabase.getUserWishList();
    List<String> _idList = [];
    for (var element in list) {
      _idList.add(element.uuid);
    }
    setState(() {
      wishPropertyIdList = _idList;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder<AllProperty>(
        future: allPropertyFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData && snapshot.data != null) {
              final List<PropertyModel> _houses = snapshot.data!.houses;
              final List<PropertyModel> _flats = snapshot.data!.flats;
              final List<PropertyModel> _rooms = snapshot.data!.rooms;

              return ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                            child: GestureDetector(
                          onTap: () {
                            
                            
                          },
                          child: TextFormField(
                            readOnly: true,
                            decoration:
                                const InputDecoration(hintText: "Search"),
                          ),
                        )),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.filter_list,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "House on Rent",
                                style: Theme.of(context).textTheme.headline4,
                              ),
                              TextButton(
                                  onPressed: () {
                                    Get.to(const PropertiesPage(
                                        type: PropertyType.house));
                                  },
                                  child: Text(
                                    "See all",
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ))
                            ],
                          ),
                        ),
                        _houses.isEmpty
                            ? Container(
                                alignment: Alignment.center,
                                height: 120.0,
                                child: const Text(
                                    "No houses on rent at the moment"),
                              )
                            : Expanded(
                                child: ListView.builder(
                                  itemCount: _houses.length,
                                  scrollDirection: Axis.horizontal,
                                  physics: const ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return HouseCard(
                                      propertyModel: _houses[index],
                                      isWished: wishPropertyIdList
                                          .getIsPropertyInWishList(
                                              _houses[index].uuid),
                                    );
                                  },
                                ),
                              )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Flats on Rent",
                                style: Theme.of(context).textTheme.headline4,
                              ),
                              TextButton(
                                  onPressed: () {
                                    Get.to(const PropertiesPage(
                                        type: PropertyType.flat));
                                  },
                                  child: Text(
                                    "See all",
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ))
                            ],
                          ),
                        ),
                        _flats.isEmpty
                            ? Container(
                                height: 120.0,
                                alignment: Alignment.center,
                                child: const Text(
                                    "No flats on rent at the moment"),
                              )
                            : Expanded(
                                child: ListView.builder(
                                  itemCount: _flats.length,
                                  scrollDirection: Axis.horizontal,
                                  physics: const ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return HouseCard(
                                      propertyModel: _flats[index],
                                      isWished: wishPropertyIdList
                                          .getIsPropertyInWishList(
                                              _flats[index].uuid),
                                    );
                                  },
                                ),
                              )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Rooms on Rent",
                                style: Theme.of(context).textTheme.headline4,
                              ),
                              TextButton(
                                  onPressed: () {
                                    Get.to(
                                      const PropertiesPage(
                                          type: PropertyType.room),
                                    );
                                  },
                                  child: Text(
                                    "See all",
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ))
                            ],
                          ),
                        ),
                        _rooms.isEmpty
                            ? Container(
                                height: 120.0,
                                alignment: Alignment.center,
                                child: const Text("No rooms at the moment"),
                              )
                            : Expanded(
                                child: ListView.builder(
                                  itemCount: _rooms.length,
                                  scrollDirection: Axis.horizontal,
                                  physics: const ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return HouseCard(
                                      propertyModel: _rooms[index],
                                      isWished: wishPropertyIdList
                                          .getIsPropertyInWishList(
                                              _rooms[index].uuid),
                                    );
                                  },
                                ),
                              )
                      ],
                    ),
                  )
                ],
              );
            } else {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
          } else {
            return Container();
          }
          
        });
        
  }
  
}
