enum DrawwerMenuItemEnum {
  home,
  myBookings,
  wishList,
  setting,
  about,
  privacy,
  share,
  logout
}

enum PropertyType { house, flat, room }

extension PropertyTypeAppBarTitleX on PropertyType {
  String getAppBarTitle() {
    switch (this) {
      case PropertyType.house:
        return "Houses on Rent";
      case PropertyType.flat:
        return "Flats on Rent";
      case PropertyType.room:
        return "Rooms on Rent";
      default:
        return "";
    }
  }
}
