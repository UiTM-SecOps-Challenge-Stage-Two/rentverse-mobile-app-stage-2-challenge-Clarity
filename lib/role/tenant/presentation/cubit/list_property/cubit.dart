import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentverse/features/property/domain/usecase/get_properties_usecase.dart';
import 'state.dart';

class ListPropertyCubit extends Cubit<ListPropertyState> {
  final GetPropertiesUseCase _getProperties;

  ListPropertyCubit(this._getProperties) : super(const ListPropertyState());

  Future<void> load({int limit = 10}) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final res = await _getProperties(limit: limit);
      emit(
        state.copyWith(
          items: res.properties,
          isLoading: false,
          hasMore: res.meta.hasMore,
          nextCursor: res.meta.nextCursor,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> loadMore({int limit = 10}) async {
    if (state.isLoadingMore || !state.hasMore || state.nextCursor == null)
      return;
    emit(state.copyWith(isLoadingMore: true, error: null));
    try {
      final res = await _getProperties(limit: limit, cursor: state.nextCursor);
      emit(
        state.copyWith(
          items: [...state.items, ...res.properties],
          isLoadingMore: false,
          hasMore: res.meta.hasMore,
          nextCursor: res.meta.nextCursor,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoadingMore: false, error: e.toString()));
    }
  }
}
