import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:lawaen/app/core/utils/enums.dart';
import 'package:lawaen/features/profile/data/models/profile_page_model.dart';
import 'package:lawaen/features/profile/data/models/profile_pages_model.dart';
import 'package:lawaen/features/profile/data/repos/profile_repo.dart';
import 'package:lawaen/features/profile/presentation/params/contact_us_params.dart';

part 'profile_state.dart';

@Singleton()
class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo _profileRepo;

  ProfileCubit(this._profileRepo) : super(const ProfileState());

  Future<void> contactUs(ContactUsParams params) async {
    emit(state.copyWith(contactUsState: RequestState.loading, contactUsError: null));

    final result = await _profileRepo.contactUs(params);
    result.fold(
      (error) => emit(state.copyWith(contactUsState: RequestState.error, contactUsError: error.errorMessage)),
      (_) => emit(state.copyWith(contactUsState: RequestState.success)),
    );
  }

  Future<void> prefetchProfilePages() async {
    if (state.getProfilePagesState == RequestState.success || state.getProfilePagesState == RequestState.loading) {
      return;
    }

    await _fetchProfilePages(showLoading: false);
  }

  Future<void> ensureProfilePagesLoaded() async {
    if (state.getProfilePagesState == RequestState.success) return;

    await _fetchProfilePages(showLoading: true);
  }

  Future<void> retryProfilePages() async {
    await _fetchProfilePages(showLoading: true, force: true);
  }

  Future<void> _fetchProfilePages({required bool showLoading, bool force = false}) async {
    if (!force &&
        (state.getProfilePagesState == RequestState.loading || state.getProfilePagesState == RequestState.success)) {
      return;
    }

    if (showLoading) {
      emit(state.copyWith(getProfilePagesState: RequestState.loading, getProfilePagesError: null));
    }

    final result = await _profileRepo.getProfilePages();
    result.fold(
      (error) =>
          emit(state.copyWith(getProfilePagesState: RequestState.error, getProfilePagesError: error.errorMessage)),
      (pages) => emit(
        state.copyWith(getProfilePagesState: RequestState.success, getProfilePages: pages, getProfilePagesError: null),
      ),
    );
  }

  String? _currentPageId;

  Future<void> getProfilePage({required String id}) async {
    _currentPageId = id;

    emit(state.copyWith(getProfilePageState: RequestState.loading, getProfilePageError: null));

    final result = await _profileRepo.getProfilePage(id: id);

    if (_currentPageId != id) return;

    result.fold(
      (error) => emit(state.copyWith(getProfilePageState: RequestState.error, getProfilePageError: error.errorMessage)),
      (page) => emit(
        state.copyWith(getProfilePageState: RequestState.success, getProfilePage: page, getProfilePageError: null),
      ),
    );
  }
}
