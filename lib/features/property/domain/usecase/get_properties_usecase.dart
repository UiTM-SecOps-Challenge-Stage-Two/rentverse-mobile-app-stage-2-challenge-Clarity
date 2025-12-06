import '../entity/list_property_entity.dart';
import '../repository/property_repository.dart';

class GetPropertiesUseCase {
  final PropertyRepository _repository;

  GetPropertiesUseCase(this._repository);

  Future<ListPropertyEntity> call({int? limit, String? cursor}) {
    return _repository.getProperties(limit: limit, cursor: cursor);
  }
}
