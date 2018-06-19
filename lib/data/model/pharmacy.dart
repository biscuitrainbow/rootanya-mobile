class Pharmacy {
  final String name;
  final double lat;
  final double lng;

  Pharmacy(this.name, this.lat, this.lng);

  @override
  String toString() {
    return 'Pharmacy{name: $name, lat: $lat, lng: $lng}';
  }


}
