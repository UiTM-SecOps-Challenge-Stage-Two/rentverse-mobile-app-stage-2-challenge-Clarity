import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:rentverse/features/property/domain/usecase/get_property_detail_usecase.dart';
import 'package:rentverse/role/tenant/presentation/cubit/rent/active_rent_detail_state.dart';

class ActiveRentDetailCubit extends Cubit<ActiveRentDetailState> {
  ActiveRentDetailCubit(this._getPropertyDetailUseCase)
    : super(const ActiveRentDetailState());

  final GetPropertyDetailUseCase _getPropertyDetailUseCase;

  Future<void> load(String propertyId) async {
    emit(state.copyWith(isLoading: true, resetError: true));
    try {
      final property = await _getPropertyDetailUseCase(propertyId);
      emit(state.copyWith(isLoading: false, property: property));
    } catch (e) {
      Logger().e('Load property detail failed', error: e);
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
