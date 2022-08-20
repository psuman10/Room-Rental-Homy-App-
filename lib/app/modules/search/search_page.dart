import 'package:flutter/material.dart';
import 'package:homy_app/app/core/utils/enum.dart';
import 'package:homy_app/app/core/utils/extension.dart';
import 'package:homy_app/app/core/values/colors.dart';
import 'package:homy_app/app/data/database/homy_database.dart';
import 'package:homy_app/app/data/models/property.dart';

import '../home/widgets/house_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<PropertyModel> _allList = [];
  List<PropertyModel> _searchedList = [];
  List<String> wishPropertyIdList = [];

  PropertyType filterProperty = PropertyType.house;
  final TextEditingController _filterPriceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getAllProperties();
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

  void getAllProperties() async {
    final _properties = await HomyDatabase.getAllProperties();
    _allList = _properties;
  }

  void search(String keyword) {
    List<PropertyModel> list = [];
    list = _allList
        .where((element) =>
            element.name.toLowerCase().contains(keyword.toLowerCase()))
        .toList();
    setState(() {
      _searchedList = list;
    });
  }

  void filter(int? price) {
    final list =
        _allList.where((element) => element.type == filterProperty).toList();

    if (price != null) {
      List<PropertyModel> _newList = [];
      for (var element in list) {
        if (element.price <= price) {
          _newList.add(element);
        }
      }
      setState(() {
        _searchedList = _newList;
      });
    } else {
      setState(() {
        _searchedList = list;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: TextFormField(
          autofocus: true,
          textInputAction: TextInputAction.search,
          onFieldSubmitted: (value) {
            search(value);
          },
          decoration: const InputDecoration(
            hintText: "Search",
            border: InputBorder.none,
            errorBorder: InputBorder.none,
            enabledBorder: UnderlineInputBorder(),
            focusedBorder: UnderlineInputBorder(),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) {
                  return StatefulBuilder(builder: (context, setState) {
                    return Dialog(
                      child: Container(
                        color: white,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Filters",
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Category",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4
                                        ?.copyWith(color: primaryBlue),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      FilterChip(
                                          selected: filterProperty ==
                                              PropertyType.house,
                                          label: const Text("House"),
                                          onSelected: (value) {
                                            setState(() {
                                              filterProperty =
                                                  PropertyType.house;
                                            });
                                          }),
                                      FilterChip(
                                          selected: filterProperty ==
                                              PropertyType.flat,
                                          label: const Text("Flat"),
                                          onSelected: (value) {
                                            print(value);
                                            setState(() {
                                              filterProperty =
                                                  PropertyType.flat;
                                            });
                                          }),
                                      FilterChip(
                                          selected: filterProperty ==
                                              PropertyType.room,
                                          label: const Text("Room"),
                                          onSelected: (value) {
                                            setState(() {
                                              filterProperty =
                                                  PropertyType.room;
                                            });
                                          }),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Price upto (Rs.)",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4
                                        ?.copyWith(color: primaryBlue),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, bottom: 16.0),
                                    child: TextFormField(
                                      controller: _filterPriceController,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                          hintText: "Enter upto price"),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Cancel"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      filter(
                                        _filterPriceController.text.isNotEmpty
                                            ? int.parse(
                                                _filterPriceController.text)
                                            : null,
                                      );
                                      Navigator.pop(context);
                                      _filterPriceController.clear();
                                    },
                                    child: const Text("Apply"),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
                },
              );
            },
            icon: const Icon(
              Icons.tune_outlined,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
            itemCount: _searchedList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12.0,
              mainAxisSpacing: 8.0,
            ),
            itemBuilder: (context, index) {
              final PropertyModel _property = _searchedList[index];
              return HouseCard(
                propertyModel: _property,
                isWished:
                    wishPropertyIdList.getIsPropertyInWishList(_property.uuid),
              );
            }),
      ),
    );
  }
}
