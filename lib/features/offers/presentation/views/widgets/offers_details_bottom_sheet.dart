import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/features/offers/presentation/views/offers_screen.dart';

class OffersDetailsBottomSheet extends StatelessWidget {
  final OffersModel offer;
  const OffersDetailsBottomSheet({super.key, required this.offer});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(35.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(offer.title, style: Theme.of(context).textTheme.displayLarge, textAlign: TextAlign.center),
          ),
          if (offer.price != null) ...[
            SizedBox(height: 8.h),
            Text(
              offer.price!,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: ColorManager.primary),
            ),
          ],
          SizedBox(height: 16.h),
          Text(offer.description, style: Theme.of(context).textTheme.headlineMedium?.copyWith(height: 1.5)),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildSocailButton(icon: Icons.facebook, onTap: () {}),
              4.horizontalSpace,
              buildSocailButton(icon: Icons.phone, onTap: () {}),
              4.horizontalSpace,
              buildSocailButton(icon: Icons.camera_alt, onTap: () {}),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildSocailButton({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(color: ColorManager.primary, borderRadius: BorderRadius.circular(10.r)),
        padding: EdgeInsets.all(8.w),
        child: Icon(icon, color: ColorManager.white, size: 20.r),
      ),
    );
  }
}
