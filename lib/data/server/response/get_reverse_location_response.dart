class GetReverseLocationResponse {
  final String name;
  final String displayName;
  final AddressInfo addressInfo;

  const GetReverseLocationResponse({
    required this.name,
    required this.displayName,
    required this.addressInfo,
  });

  factory GetReverseLocationResponse.fromMap(Map<String, dynamic> map) {
    return GetReverseLocationResponse(
      name: map['name'] as String,
      displayName: map['display_name'] as String,
      addressInfo: AddressInfo.fromMap(map['address']),
    );
  }

  @override
  String toString() {
    return 'GetReverseLocationResponse{name: $name, displayName: $displayName, addressInfo: $addressInfo}';
  }
}

class AddressInfo {
  final String city;
  final String postCode;
  final String country;
  final String countryCode;

  const AddressInfo({
    required this.city,
    required this.postCode,
    required this.country,
    required this.countryCode,
  });

  factory AddressInfo.fromMap(Map<String, dynamic> map) {
    return AddressInfo(
      city: map['city'] as String,
      postCode: map['postcode'] as String,
      country: map['country'] as String,
      countryCode: map['country_code'] as String,
    );
  }

  @override
  String toString() {
    return 'AddressInfo{city: $city, postCode: $postCode, country: $country, countryCode: $countryCode}';
  }
}
