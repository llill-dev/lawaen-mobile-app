import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lawaen/app/routes/router.gr.dart';

import '../../../../app/core/refresh_cubit/refresh_cubit.dart';
import '../../../../app/di/injection.dart';
import '../../../../app/resources/assets_manager.dart';
import '../../../../app/resources/color_manager.dart';
import '../../../../generated/locale_keys.g.dart';

import 'home_screen.dart';
import 'package:lawaen/features/explore/presentation/views/explore_screen.dart';
import 'package:lawaen/features/offers/presentation/views/offers_screen.dart';
import 'package:lawaen/features/events/presentation/views/events_screen.dart';

@RoutePage()
class NavigationControllerScreen extends StatefulWidget {
  final int initialIndex;

  const NavigationControllerScreen({super.key, this.initialIndex = 0});

  @override
  State<NavigationControllerScreen> createState() => _NavigationControllerScreenState();
}

class _NavigationControllerScreenState extends State<NavigationControllerScreen> {
  late final PageController _pageController;
  final _refreshCubit = getIt<RefreshCubit>();

  int _currentIndex = 0;
  int _lastRealIndex = 0;

  bool _isNavigatingToNearby = false;

  late final List<Widget> _pages = [
    const HomeScreen(),
    const ExploreScreen(),
    const SizedBox.shrink(), // Nearby placeholder
    const OffersScreen(),
    const EventsScreen(),
  ];

  @override
  void initState() {
    super.initState();

    _currentIndex = widget.initialIndex.clamp(0, 4);
    _lastRealIndex = _currentIndex;

    _pageController = PageController(initialPage: _currentIndex);
  }

  // ---------------------------
  // Nearby navigation (SAFE)
  // ---------------------------
  Future<void> _openNearbyMap() async {
    if (_isNavigatingToNearby) return;

    _isNavigatingToNearby = true;

    await context.router.push(const NearbyMapRoute());

    _isNavigatingToNearby = false;
  }

  // ---------------------------
  // Bottom nav tap
  // ---------------------------
  void _onNavBarTapped(int index) {
    HapticFeedback.lightImpact();

    if (index == 2) {
      _openNearbyMap();
      return;
    }

    if (_currentIndex == index) return;

    setState(() {
      _currentIndex = index;
      _lastRealIndex = index;
    });

    _pageController.jumpToPage(index);
  }

  // ---------------------------
  // PageView change
  // ---------------------------
  void _onPageChanged(int index) {
    if (index == 2) {
      _openNearbyMap();
      _pageController.jumpToPage(_lastRealIndex);
      return;
    }

    setState(() {
      _currentIndex = index;
      _lastRealIndex = index;
    });

    _refreshCubit.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        physics: const BouncingScrollPhysics(),
        children: _pages,
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // ---------------------------
  // Bottom Navigation Bar
  // ---------------------------
  Widget _buildBottomNav() {
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

    return Material(
      color: Colors.transparent,
      child: Container(
        height: 74.h,
        decoration: BoxDecoration(
          color: ColorManager.primary,
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
          border: Border(top: BorderSide(color: ColorManager.white, width: 2)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(icons.length, (index) => _buildNavItem(index, titles[index], icons[index])),
        ),
      ),
    );
  }

  // ---------------------------
  // Animated Nav Item
  // ---------------------------
  Widget _buildNavItem(int index, String title, List<String> icons) {
    final bool selected = index == _currentIndex;

    return InkWell(
      onTap: () => _onNavBarTapped(index),
      borderRadius: BorderRadius.circular(16),
      splashColor: Colors.white24,
      highlightColor: Colors.transparent,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        width: 60.w,
        padding: EdgeInsets.symmetric(vertical: 6.h),
        transform: Matrix4.identity()..scale(selected ? 1.15 : 1.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: SvgPicture.asset(
                selected ? icons[0] : icons[1],
                key: ValueKey(selected),
                width: 20.w,
                colorFilter: ColorFilter.mode(selected ? ColorManager.black : ColorManager.white, BlendMode.srcIn),
              ),
            ),
            SizedBox(height: 6.h),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                fontSize: 10,
                fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                color: selected ? ColorManager.black : ColorManager.white,
              ),
              child: Text(title),
            ),
          ],
        ),
      ),
    );
  }
}
