import 'package:flutter/material.dart';
import 'package:homy_app/app/core/utils/enum.dart';
import 'package:homy_app/app/core/utils/extension.dart';
import 'package:homy_app/app/data/database/homy_database.dart';
import 'package:homy_app/app/data/models/property.dart';
import 'package:homy_app/app/modules/home/widgets/house_card.dart';

class PropertiesPage extends StatefulWidget {
  const PropertiesPage({Key? key, required this.type}) : super(key: key);

  final PropertyType type;

  @override
  State<PropertiesPage> createState() => _PropertiesPageState();
}

class _PropertiesPageState extends State<PropertiesPage> {
  late final Future<List<PropertyModel>> _propertiesFuture;

  PropertyType get type => widget.type;

  List<String> wishPropertyIdList = [];

  @override
  void initState() {
    super.initState();
    getFuture();
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

  getFuture() async {
    switch (type) {
      case PropertyType.house:
        _propertiesFuture = HomyDatabase.getHouseProperties();
        break;
      case PropertyType.flat:
        _propertiesFuture = HomyDatabase.getFlatProperties();
        break;
      case PropertyType.room:
        _propertiesFuture = HomyDatabase.getRoomProperties();
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          type.getAppBarTitle(),
        ),
      ),
      body: FutureBuilder<List<PropertyModel>>(
          future: _propertiesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData && snapshot.data != null) {
                final List<PropertyModel> _houseList = snapshot.data!;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                      itemCount: _houseList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12.0,
                        mainAxisSpacing: 8.0,
                      ),
                      itemBuilder: (context, index) {
                        final PropertyModel _property = _houseList[index];
                        return HouseCard(
                          propertyModel: _property,
                          isWished: wishPropertyIdList
                              .getIsPropertyInWishList(_property.uuid),
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
    );
  }
}
