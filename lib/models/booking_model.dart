class BookingModel {
  BookingModel({
    required this.checkout,
    required this.checkin,
    required this.isAC,
    this.bookingId,
    this.bookingTime,
  });

  bool isAC;
  String checkin;
  String? bookingId;
  String checkout;
  String? bookingTime;

  Map<String, dynamic> toJson() {
    return {"title": checkin, "description": checkout, "is_completed": isAC};
  }

  factory BookingModel.fromJson(Map<String, dynamic> map) {
    var mapData = map['data'];
    return BookingModel(
        checkout: mapData['description'],
        checkin: mapData['title'],
        isAC: mapData['is_completed'],
        bookingId: mapData['_id'],
        bookingTime: mapData['created_at']);
  }
}
