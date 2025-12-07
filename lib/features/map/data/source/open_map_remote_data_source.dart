import 'package:rentverse/core/network/open_map_street_api.dart';
import 'package:rentverse/features/map/data/models/reverse_geocode_response_model.dart';

abstract class OpenMapRemoteDataSource {
  Future<ReverseGeocodeResponseModel> reverseGeocode({
    required double lat,
    required double lon,
  });
}

class OpenMapRemoteDataSourceImpl implements OpenMapRemoteDataSource {
  final OpenMapStreetApi api;

  OpenMapRemoteDataSourceImpl(this.api);

  @override
  Future<ReverseGeocodeResponseModel> reverseGeocode({
    required double lat,
    required double lon,
  }) async {
    final response = await api.reverseGeocode(lat: lat, lon: lon);
    return ReverseGeocodeResponseModel.fromJson(
      response.data as Map<String, dynamic>,
    );
  }
}
