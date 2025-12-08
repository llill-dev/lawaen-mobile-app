import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:lawaen/app/core/utils/enums.dart';
import 'package:lawaen/features/events/data/models/event_type_model.dart';
import 'package:lawaen/features/events/data/repos/event_repo.dart';

part 'event_state.dart';

@singleton
class EventCubit extends Cubit<EventState> {
  final EventRepo _eventRepo;

  EventCubit(this._eventRepo) : super(const EventState());

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
}
