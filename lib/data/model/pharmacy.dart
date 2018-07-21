class Pharmacy {
  final String name;
  final double lat;
  final double lng;
  final bool isOpening;

  Pharmacy(
    this.name,
    this.lat,
    this.lng,
    this.isOpening,
  );

  @override
  String toString() {
    return 'Pharmacy{name: $name, lat: $lat, lng: $lng}';
  }
}
