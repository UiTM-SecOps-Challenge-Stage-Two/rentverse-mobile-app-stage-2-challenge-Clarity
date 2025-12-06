import 'package:equatable/equatable.dart';
import 'package:rentverse/features/property/domain/entity/list_property_entity.dart';

class ListPropertyState extends Equatable {
  final List<PropertyEntity> items;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String? nextCursor;
  final String? error;

  const ListPropertyState({
    this.items = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.nextCursor,
    this.error,
  });

  ListPropertyState copyWith({
    List<PropertyEntity>? items,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    String? nextCursor,
    String? error,
  }) {
    return ListPropertyState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      nextCursor: nextCursor ?? this.nextCursor,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
    items,
    isLoading,
    isLoadingMore,
    hasMore,
    nextCursor,
    error,
  ];
}
