import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/core/functions/url_launcher.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/features/offers/data/models/offer_model.dart';

class OffersDetailsBottomSheet extends StatelessWidget {
  final OfferModel offer;
  const OffersDetailsBottomSheet({super.key, required this.offer});

  bool _isWhatsAppNumber(String number) {
    return number.startsWith("https://wa.me/") || number.startsWith("http://wa.me/") || number.contains("whatsapp");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(35.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(offer.name, style: Theme.of(context).textTheme.displayLarge, textAlign: TextAlign.center),
          ),

          SizedBox(height: 16.h),

          Text(offer.description, style: Theme.of(context).textTheme.headlineMedium?.copyWith(height: 1.5)),

          SizedBox(height: 16.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (offer.facebook != null)
                buildSocialButton(
                  icon: Icons.facebook,
                  onTap: () {
                    launchURL(link: offer.facebook!);
                  },
                ),

              4.horizontalSpace,

              if (offer.phone != null)
                buildSocialButton(
                  icon: Icons.phone,
                  onTap: () {
                    final phone = offer.phone!.trim();

                    if (_isWhatsAppNumber(phone)) {
                      launchURL(link: phone);
                    } else {
                      makePhoneCall(phone);
                    }
                  },
                ),

              4.horizontalSpace,

              if (offer.phone != null && !_isWhatsAppNumber(offer.phone!))
                buildSocialButton(
                  icon: Icons.copy,
                  onTap: () {
                    copyToClipboard(offer.phone!);
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildSocialButton({required IconData icon, required VoidCallback onTap}) {
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
