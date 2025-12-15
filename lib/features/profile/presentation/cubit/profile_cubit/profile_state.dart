part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  final RequestState contactUsState;
  final String? contactUsError;

  final RequestState getProfilePagesState;
  final List<ProfilePagesModel> getProfilePages;
  final String? getProfilePagesError;

  final RequestState getProfilePageState;
  final ProfilePageModel? getProfilePage;
  final String? getProfilePageError;

  final RequestState getCountsState;
  final CountsModel? getCounts;
  final String? getCountsError;

  final RequestState getRatedState;
  final List<CategoryDetailsModel> getRated;
  final String? getRatedError;

  final RequestState getSavedState;
  final List<CategoryDetailsModel> getSaved;
  final String? getSavedError;

  const ProfileState({
    this.contactUsState = RequestState.idle,
    this.contactUsError,
    this.getProfilePagesState = RequestState.idle,
    this.getProfilePages = const [],
    this.getProfilePagesError,
    this.getProfilePageState = RequestState.idle,
    this.getProfilePage,
    this.getProfilePageError,
    this.getCountsState = RequestState.idle,
    this.getCounts,
    this.getCountsError,
    this.getRatedState = RequestState.idle,
    this.getRated = const [],
    this.getRatedError,
    this.getSavedState = RequestState.idle,
    this.getSaved = const [],
    this.getSavedError,
  });

  ProfileState copyWith({
    RequestState? contactUsState,
    String? contactUsError,
    RequestState? getProfilePagesState,
    List<ProfilePagesModel>? getProfilePages,
    String? getProfilePagesError,
    RequestState? getProfilePageState,
    ProfilePageModel? getProfilePage,
    String? getProfilePageError,
    RequestState? getCountsState,
    CountsModel? getCounts,
    String? getCountsError,
    RequestState? getRatedState,
    List<CategoryDetailsModel>? getRated,
    String? getRatedError,
    RequestState? getSavedState,
    List<CategoryDetailsModel>? getSaved,
    String? getSavedError,
  }) {
    return ProfileState(
      contactUsState: contactUsState ?? this.contactUsState,
      contactUsError: contactUsError ?? this.contactUsError,
      getProfilePagesState: getProfilePagesState ?? this.getProfilePagesState,
      getProfilePages: getProfilePages ?? this.getProfilePages,
      getProfilePagesError: getProfilePagesError ?? this.getProfilePagesError,
      getProfilePageState: getProfilePageState ?? this.getProfilePageState,
      getProfilePage: getProfilePage ?? this.getProfilePage,
      getProfilePageError: getProfilePageError ?? this.getProfilePageError,
      getCountsState: getCountsState ?? this.getCountsState,
      getCounts: getCounts ?? this.getCounts,
      getCountsError: getCountsError ?? this.getCountsError,
      getRatedState: getRatedState ?? this.getRatedState,
      getRated: getRated ?? this.getRated,
      getRatedError: getRatedError ?? this.getRatedError,
      getSavedState: getSavedState ?? this.getSavedState,
      getSaved: getSaved ?? this.getSaved,
      getSavedError: getSavedError ?? this.getSavedError,
    );
  }

  @override
  List<Object?> get props => [
    contactUsState,
    contactUsError,
    getProfilePagesState,
    getProfilePages,
    getProfilePagesError,
    getProfilePageState,
    getProfilePage,
    getProfilePageError,
    getCountsState,
    getCounts,
    getCountsError,
    getRatedState,
    getRated,
    getRatedError,
    getSavedState,
    getSaved,
    getSavedError,
  ];
}
