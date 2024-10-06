import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapState {
  final LatLng location;
  final LatLng temp;

  MapState({
    required this.temp,
    required this.location,
  });

  factory MapState.initial() {
    return MapState(
      location: const LatLng(15.369445, 44.191006),
      temp: const LatLng(15.369445, 44.191006),
    );
  }

  MapState copyWith({
    LatLng? temp,
    LatLng? location,
  }) {
    return MapState(
      temp: temp ?? this.temp,
      location: location ?? this.location,
    );
  }
}
