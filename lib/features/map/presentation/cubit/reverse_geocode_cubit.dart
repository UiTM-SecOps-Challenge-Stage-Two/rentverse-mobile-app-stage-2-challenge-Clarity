import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentverse/features/map/domain/usecase/reverse_geocode_usecase.dart';
import 'reverse_geocode_state.dart';

class ReverseGeocodeCubit extends Cubit<ReverseGeocodeState> {
  ReverseGeocodeCubit(this._useCase) : super(ReverseGeocodeState.initial());

  final ReverseGeocodeUseCase _useCase;

  Future<void> fetch(double lat, double lon) async {
    emit(state.copyWith(status: ReverseGeocodeStatus.loading, error: null));
    try {
      final result = await _useCase(
        param: ReverseGeocodeParams(lat: lat, lon: lon),
      );
      emit(
        state.copyWith(
          status: ReverseGeocodeStatus.success,
          location: result,
          error: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ReverseGeocodeStatus.failure,
          error: e.toString(),
        ),
      );
    }
  }
}
