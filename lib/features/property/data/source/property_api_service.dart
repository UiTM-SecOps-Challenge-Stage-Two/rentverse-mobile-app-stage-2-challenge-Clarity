import 'package:rentverse/core/network/dio_client.dart';
import 'package:rentverse/features/property/data/models/list_property_response_model.dart';

abstract class PropertyApiService {
  Future<ListPropertyResponseModel> getProperties({int? limit, String? cursor});
}

class PropertyApiServiceImpl implements PropertyApiService {
  final DioClient _dioClient;

  PropertyApiServiceImpl(this._dioClient);

  @override
  Future<ListPropertyResponseModel> getProperties({
    int? limit,
    String? cursor,
  }) async {
    try {
      final response = await _dioClient.get(
        '/properties',
        queryParameters: {
          if (limit != null) 'limit': limit,
          if (cursor != null) 'cursor': cursor,
        },
      );
      return ListPropertyResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    } catch (e) {
      rethrow;
    }
  }
}
