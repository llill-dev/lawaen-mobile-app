import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
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
  late final List<Widget> _pages = [
    const HomeScreen(),
    const ExploreScreen(),
    const SizedBox.shrink(),
    OffersScreen(),
    const EventsScreen(),
  ];
  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex.clamp(0, 4);
    _lastRealIndex = _currentIndex;
    _pageController = PageController(initialPage: _currentIndex);
  }

  void _onNavBarTapped(int index) {
    if (index == 2) {
      context.router.push(const NearbyMapRoute());
      return;
    }
    setState(() {
      _currentIndex = index;
      _lastRealIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  void _onPageChanged(int index) {
    if (index == 2) {
      context.router.push(const NearbyMapRoute());
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
      appBar: AppBar(),
      extendBodyBehindAppBar: true,
      body: PageView(
        clipBehavior: Clip.none,
        controller: _pageController,
        onPageChanged: _onPageChanged,
        physics: const BouncingScrollPhysics(),
        children: _pages,
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

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
      borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
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

  Widget _buildNavItem(int index, String title, List<String> icons) {
    final bool selected = index == _currentIndex;
    return GestureDetector(
      onTap: () => _onNavBarTapped(index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 60.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              selected ? icons[0] : icons[1],
              width: 20.w,
              colorFilter: ColorFilter.mode(selected ? ColorManager.black : ColorManager.white, BlendMode.srcIn),
            ),
            SizedBox(height: 6.h),
            Text(title, style: TextStyle(fontSize: 10, color: selected ? ColorManager.black : ColorManager.white)),
          ],
        ),
      ),
    );
  }
}
