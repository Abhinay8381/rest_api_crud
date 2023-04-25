class BookingModel {
  BookingModel({
    required this.checkout,
    required this.checkin,
    required this.isAC,
  });

  bool isAC;
  String checkin;

  String checkout;

  Map<String, dynamic> toJson() {
    return {"title": checkin, "description": checkout, "is_completed": isAC};
  }
}
