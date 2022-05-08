import 'package:geolocator/geolocator.dart';

class Location {
  late double latitude;
  late double longitude;
  Future<void> getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    latitude = position.latitude;
    longitude = position.longitude;
  }
}
