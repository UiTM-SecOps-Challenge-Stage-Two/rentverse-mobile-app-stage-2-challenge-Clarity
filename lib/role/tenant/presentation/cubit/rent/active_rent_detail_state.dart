import 'package:rentverse/features/property/domain/entity/list_property_entity.dart';

class ActiveRentDetailState {
  final bool isLoading;
  final String? error;
  final PropertyEntity? property;

  const ActiveRentDetailState({
    this.isLoading = false,
    this.error,
    this.property,
  });

  ActiveRentDetailState copyWith({
    bool? isLoading,
    String? error,
    PropertyEntity? property,
    bool resetError = false,
  }) {
    return ActiveRentDetailState(
      isLoading: isLoading ?? this.isLoading,
      error: resetError ? null : error ?? this.error,
      property: property ?? this.property,
    );
  }
}
