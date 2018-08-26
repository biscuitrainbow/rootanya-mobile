import 'package:medical_app/constants.dart';

String acceptApplicationJson = 'application/json';

String createBearer(String token) {
  return 'Bearer $token';
}

String createGoogleMapUrl(double lat, double lng, String name) {
  return '${Http.googleMap}/maps?q= $lat,$lng($name)&iwloc=A&hl=es';
}

String createAppleMapUrl(double lat, double lng, String name) {
  return '${Http.appleMap}/?ll=$lat,$lng&z=5&q=$name';
}

String createMapBoxUrl() {
  return "${Http.mapBoxUrl}/styles/v1/rajayogan/cjl1bndoi2na42sp2pfh2483p/tiles/256/{z}/{x}/{y}@2x?access_token=${Environment.mapBoxAccessToken}";
}
