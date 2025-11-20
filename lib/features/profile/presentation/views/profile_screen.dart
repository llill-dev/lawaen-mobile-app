import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:lawaen/features/profile/presentation/views/widget/profile_body/settings_section.dart';
import 'package:lawaen/features/profile/presentation/views/widget/profile_header/profile_header.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(clipBehavior: Clip.none, slivers: [ProfileHeader(), SettingsSection()]),
      ),
    );
  }
}
