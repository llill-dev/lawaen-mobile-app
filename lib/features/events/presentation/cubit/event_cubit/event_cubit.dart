import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:lawaen/app/core/utils/enums.dart';
import 'package:lawaen/app/location_manager/location_service.dart';
import 'package:lawaen/features/events/data/models/event_model.dart';
import 'package:lawaen/features/events/data/models/event_type_model.dart';
import 'package:lawaen/features/events/data/repos/event_repo.dart';
import 'package:lawaen/features/events/presentation/params/get_events_params.dart';

part 'event_state.dart';

@singleton
class EventCubit extends Cubit<EventState> {
  final EventRepo _eventRepo;

  final LocationService _locationService;

  EventCubit(this._eventRepo, this._locationService) : super(const EventState());

  Future<void> getEventTypes() async {
    emit(state.copyWith(eventTypesState: RequestState.loading, eventTypesError: null));

    final result = await _eventRepo.getEventTypes();
    result.fold(
      (failure) {
        emit(state.copyWith(eventTypesState: RequestState.error, eventTypesError: failure.errorMessage));
      },
      (types) {
        emit(state.copyWith(eventTypesState: RequestState.success, eventTypes: types, eventTypesError: null));
      },
    );
  }

  Future<void> getEvents({required String eventTypeId}) async {
    emit(state.copyWith(eventsState: RequestState.loading, eventsError: null));

    final cityId = await _getUserCity();
    final params = GetEventsParams(city: cityId);

    final result = await _eventRepo.getEvents(params: params, eventTypeId: eventTypeId);

    result.fold(
      (failure) {
        emit(state.copyWith(eventsState: RequestState.error, eventsError: failure.errorMessage));
      },
      (events) {
        emit(state.copyWith(eventsState: RequestState.success, events: events, eventsError: null));
      },
    );
  }

  Future<String> _getUserCity() async {
    final userLocation = await _locationService.getBestEffortLocation();
    return userLocation.cityId ?? "";
  }
}
