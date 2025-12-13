import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:lawaen/app/core/utils/enums.dart';
import 'package:lawaen/features/profile/data/repos/profile_repo.dart';
import 'package:lawaen/features/profile/presentation/params/contact_us_params.dart';

part 'profile_state.dart';

@Injectable()
class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo _profileRepo;

  ProfileCubit(this._profileRepo) : super(const ProfileState());

  Future<void> contactUs(ContactUsParams params) async {
    emit(state.copyWith(contactUsState: RequestState.loading, contactUsError: null));

    final result = await _profileRepo.contactUs(params);
    result.fold(
      (error) => emit(state.copyWith(contactUsState: RequestState.error, contactUsError: error.errorMessage)),
      (_) => emit(state.copyWith(contactUsState: RequestState.success, contactUsError: null)),
    );
  }
}
