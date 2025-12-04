import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/app/resources/color_manager.dart';

class HomeSocialLinks extends StatelessWidget {
  const HomeSocialLinks({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> links = [IconManager.facebook, IconManager.insta];
    return SliverToBoxAdapter(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(links.length, (index) => _buildLinkItem(item: links[index])),
      ),
    );
  }

  Widget _buildLinkItem({required String item}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6.w),
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(color: ColorManager.primary, shape: BoxShape.circle),
      child: SvgPicture.asset(
        item,
        colorFilter: ColorFilter.mode(ColorManager.white, BlendMode.srcIn),
        width: 25.r,
        height: 25.r,
      ),
    );
  }
}
