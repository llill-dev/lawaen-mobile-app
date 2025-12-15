import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lawaen/app/app_prefs.dart';
import 'package:lawaen/app/di/injection.dart';
import 'package:lawaen/features/profile/presentation/cubit/profile_cubit/profile_cubit.dart';
import 'package:lawaen/features/profile/presentation/views/widget/profile_body/settings_section.dart';
import 'package:lawaen/features/profile/presentation/views/widget/profile_header/profile_header.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    final profileCubit = context.read<ProfileCubit>();
    profileCubit.ensureProfilePagesLoaded();
    if (!getIt<AppPreferences>().isGuest) {
      profileCubit.getCounts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(clipBehavior: Clip.none, slivers: [ProfileHeader(), SettingsSection()]),
      ),
    );
  }
}
