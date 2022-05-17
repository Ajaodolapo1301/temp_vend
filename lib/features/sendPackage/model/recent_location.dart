class RecentLocation {
  String? destinationLat;
  String? destinationLong;
  String? destinationAddress;
  String? destinationFormattedAddress;
  String? destinationRawResponse;

  RecentLocation(
      {this.destinationLat,
      this.destinationLong,
      this.destinationAddress,
      this.destinationFormattedAddress,
      this.destinationRawResponse});

  RecentLocation.fromJson(Map<String, dynamic> json) {
    destinationLat = json['destination_lat'];
    destinationLong = json['destination_long'];
    destinationAddress = json['destination_address'];
    destinationFormattedAddress = json['destination_formatted_address'];
    destinationRawResponse = json['destination_raw_response'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['destination_lat'] = destinationLat;
    data['destination_long'] = destinationLong;
    data['destination_address'] = destinationAddress;
    data['destination_formatted_address'] = destinationFormattedAddress;
    data['destination_raw_response'] = destinationRawResponse;
    return data;
  }
}
