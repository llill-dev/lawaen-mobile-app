import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lawaen/features/events/presentation/views/events_screen.dart';
import 'package:lawaen/features/explore/presentation/views/explore_screen.dart';
import 'package:lawaen/features/offers/presentation/views/offers_screen.dart';

import '../../../../app/app_prefs.dart';
import '../../../../app/core/refresh_cubit/refresh_cubit.dart';
import '../../../../app/di/injection.dart';
import '../../../../app/resources/assets_manager.dart';
import '../../../../app/resources/color_manager.dart';
import '../../../../generated/locale_keys.g.dart';
import 'home_screen.dart';

@RoutePage()
class NavigationControllerScreen extends StatefulWidget {
  final int initialIndex;
  const NavigationControllerScreen({super.key, this.initialIndex = 0});

  @override
  State<NavigationControllerScreen> createState() => NavigationControllerScreenState();
}

class NavigationControllerScreenState extends State<NavigationControllerScreen> {
  int _currentIndex = 0;

  late final PageController _pageController;
  final _refreshCubit = getIt<RefreshCubit>();
  final AppPreferences appPreferences = getIt<AppPreferences>();
  bool _isFabOpen = false;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [HomeScreen(), ExploreScreen(), Container(), OffersScreen(), EventsScreen()];

    _currentIndex = widget.initialIndex.clamp(0, _pages.length - 1);

    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void _onPageChanged(int index) {
    _currentIndex = index;

    _refreshCubit.refresh();
  }

  void _onNavBarTapped(int index) {
    if (_currentIndex != index) {
      _pageController.jumpToPage(index);
    }
  }

  void _toggleFab() {
    setState(() {
      _isFabOpen = !_isFabOpen;
    });
  }

  List<Widget> _buildSocialButtons() {
    final socialIcons = [Icons.facebook, Icons.camera_alt_outlined];

    return List.generate(socialIcons.length, (i) {
      return AnimatedPositioned(
        duration: Duration(milliseconds: 250 + (i * 100)),
        bottom: (i + 1) * 70.0,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: _isFabOpen ? 1 : 0,
          child: FloatingActionButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
            backgroundColor: ColorManager.primary,
            onPressed: () {
              // TODO: open your social link (e.g., launchUrl)
            },
            child: Icon(socialIcons[i], color: ColorManager.white, size: 30.w),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RefreshCubit, RefreshState>(
      bloc: _refreshCubit,
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: Stack(
            alignment: Alignment.bottomLeft,
            clipBehavior: Clip.none,
            children: [
              if (_isFabOpen) ..._buildSocialButtons(),
              FloatingActionButton(
                onPressed: _toggleFab,
                elevation: 0,
                backgroundColor: ColorManager.primary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  transitionBuilder: (child, anim) => RotationTransition(turns: anim, child: child),
                  child: Icon(
                    _isFabOpen ? Icons.close : Icons.add,
                    key: ValueKey(_isFabOpen),
                    color: ColorManager.white,
                    size: 40.w,
                  ),
                ),
              ),
            ],
          ),
          extendBody: true,
          bottomNavigationBar: Material(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
            child: Container(
              height: 74.h,
              decoration: BoxDecoration(
                color: ColorManager.white,
                border: Border.all(color: ColorManager.lightGrey, width: 1.9),
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(5, (index) => _buildNavItem(index)),
              ),
            ),
          ),
          body: PageView(controller: _pageController, onPageChanged: _onPageChanged, children: _pages),
        );
      },
    );
  }

  Widget _buildNavItem(int index) {
    final bool isSelected = _currentIndex == index;
    final icons = [
      [IconManager.homeFill, IconManager.home],
      [IconManager.exploreFill, IconManager.explore],
      [IconManager.nearby, IconManager.nearby],
      [IconManager.offersFill, IconManager.offers],
      [IconManager.eventsFill, IconManager.events],
    ];

    final titles = [
      LocaleKeys.home.tr(),
      LocaleKeys.explore.tr(),
      LocaleKeys.nearby.tr(),
      LocaleKeys.offers.tr(),
      LocaleKeys.events.tr(),
    ];

    return GestureDetector(
      onTap: () {
        _onNavBarTapped(index);
      },
      child: FittedBox(
        fit: BoxFit.contain,
        child: Column(
          children: [
            SvgPicture.asset(
              isSelected ? icons[index][0] : icons[index][1],
              width: 20.w,
              colorFilter: isSelected ? ColorFilter.mode(ColorManager.primary, BlendMode.srcIn) : null,
            ),
            6.verticalSpace,
            Text(
              titles[index],
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: isSelected ? ColorManager.primary : ColorManager.blackSwatch[10]!,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
