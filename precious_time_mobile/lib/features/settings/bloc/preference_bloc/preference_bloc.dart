import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:precious_time_mobile/core/models/edit_preference_dto.dart';
import 'package:precious_time_mobile/core/models/preference_response.dart';
import 'package:precious_time_mobile/core/service/preference_service.dart';

part 'preference_event.dart';
part 'preference_state.dart';

class PreferenceBloc extends Bloc<PreferenceEvent, PreferenceState> {
  PreferenceBloc(PreferenceService preferenceService) : super(PreferenceInitial()) {
    on<PreferenceFetchEvent>((event, emit) async {
      emit(PreferenceLoading());
      try {
        var preference = await preferenceService.getPreference();
        emit(PreferenceSuccess(preferenceResponse: preference));
      } catch (e) {
        emit(PreferenceError(message: e.toString()));
      }
    });

    on<PreferenceEditEvent>((event, emit) async {
      emit(PreferenceLoading());
      try {
        var preference = await preferenceService.editPreference(event.id, event.dto);
        emit(PreferenceEditSuccess(preferenceResponse: preference));
      } catch (e) {
        emit(PreferenceError(message: e.toString()));
      }
    });
  }
}
