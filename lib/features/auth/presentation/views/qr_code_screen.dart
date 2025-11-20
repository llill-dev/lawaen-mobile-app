import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lawaen/app/core/widgets/primary_button.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/app/routes/router.gr.dart';
import 'package:lawaen/generated/locale_keys.g.dart';
import 'package:qr_flutter/qr_flutter.dart';

@RoutePage()
class QrCodeScreen extends StatelessWidget {
  final String fakeUserId = "USER123456";

  const QrCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Image.asset(ImageManager.qrCodeTop, width: double.infinity, fit: BoxFit.cover),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Image.asset(ImageManager.qrCodeBottom, width: double.infinity, fit: BoxFit.cover),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        LocaleKeys.thankYou.tr(),
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 24),
                      ),
                      6.horizontalSpace,
                      SvgPicture.asset(IconManager.heart),
                    ],
                  ),
                  12.verticalSpace,

                  Text("ayham", style: Theme.of(context).textTheme.displayLarge),

                  8.verticalSpace,

                  Text(LocaleKeys.yourQR.tr(), style: Theme.of(context).textTheme.headlineMedium),

                  32.verticalSpace,

                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: ColorManager.primary, width: 3),
                      boxShadow: [BoxShadow(blurRadius: 25, color: ColorManager.black.withValues(alpha: 0.7))],
                    ),
                    child: QrImageView(data: fakeUserId, version: QrVersions.auto, size: 220, gapless: false),
                  ),

                  40.verticalSpace,

                  PrimaryButton(
                    text: LocaleKeys.next.tr(),
                    backgroundColor: ColorManager.blackSwatch[3],
                    borederColor: ColorManager.blackSwatch[3],
                    textColor: ColorManager.black,
                    withShadow: true,
                    shadowColor: ColorManager.onBoardingShadowColor,
                    onPressed: () {
                      context.router.pushAndPopUntil(NavigationControllerRoute(), predicate: (route) => false);
                    },
                    height: 40.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
