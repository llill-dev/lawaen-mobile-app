import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/features/home/data/models/banner_model.dart';

import 'banner_item_widget.dart';

class BannersSection extends StatefulWidget {
  final List<BannerModel> banners;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final bool showIndicators;
  final Duration? autoScrollInterval;

  const BannersSection({
    super.key,
    required this.banners,
    this.height,
    this.padding,
    this.showIndicators = true,
    this.autoScrollInterval = const Duration(seconds: 5),
  });

  @override
  State<BannersSection> createState() => _BannersSectionState();
}

class _BannersSectionState extends State<BannersSection> {
  late final PageController _pageController;
  Timer? _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    _pageController.addListener(() {
      final page = _pageController.page?.round() ?? 0;
      if (page != _currentPage) {
        setState(() => _currentPage = page);
      }
    });

    _startAutoScroll();
  }

  void _startAutoScroll() {
    if (widget.banners.length <= 1) return;

    _timer = Timer.periodic(widget.autoScrollInterval ?? const Duration(seconds: 5), (timer) {
      if (!mounted) return;

      final nextPage = (_currentPage + 1) % widget.banners.length;

      _pageController.animateToPage(nextPage, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    });
  }

  void _stopAutoScroll() {
    _timer?.cancel();
    _timer = null;
  }

  void _restartAutoScroll() {
    _stopAutoScroll();
    _startAutoScroll();
  }

  @override
  void didUpdateWidget(covariant BannersSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.banners != widget.banners) {
      _restartAutoScroll();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.banners.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        AspectRatio(
          aspectRatio: 16 / 4,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.banners.length,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            itemBuilder: (context, index) {
              final banner = widget.banners[index];
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: BannerItemWidget(
                  banner: banner,
                  height: widget.height,
                  fit: BoxFit.fill,
                  borderRadius: BorderRadius.circular(12.r),
                ),
              );
            },
          ),
        ),
        // if (widget.showIndicators && widget.banners.length > 1) ...[
        //   SizedBox(height: 12.h),
        //   Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: List.generate(widget.banners.length, (index) {
        //       return Container(
        //         margin: EdgeInsets.symmetric(horizontal: 4.w),
        //         width: 8.w,
        //         height: 8.h,
        //         decoration: BoxDecoration(
        //           shape: BoxShape.circle,
        //           color: _currentPage == index ? ColorManager.primary : Colors.grey.withOpacity(0.5),
        //         ),
        //       );
        //     }),
        //   ),
        //],
      ],
    );
  }
}
