extension WishListX on List<String> {
  bool getIsPropertyInWishList(String propertyId) {
    final exist = contains(propertyId);
    return exist;
  }
}

extension BookingListX on List<String> {
  bool getIsPropertyIsBooked(String propertyId) {
    final exist = contains(propertyId);
    return exist;
  }
}

extension AdvanceAmountX on int {
  int getAdvanceAmount() {
    final int amount = (this * 0.1).toInt().round();
    return amount;
  }
}
