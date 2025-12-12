import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/core/functions/url_launcher.dart';
import 'package:lawaen/app/di/injection.dart';
import 'package:lawaen/app/location_manager/location_service.dart';
import 'package:lawaen/features/home/data/models/category_item_model.dart';
import 'package:lawaen/features/home/presentation/views/widgets/category_item_details/links_item_detials.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

class ItemDetialsLinksRow extends StatelessWidget {
  const ItemDetialsLinksRow({super.key, required this.itemData});

  final ItemData itemData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.12.sh * 0.4,
      child: ListView(
        clipBehavior: Clip.none,
        scrollDirection: Axis.horizontal,
        children: [
          Row(
            children: [
              LinksItemDetials(
                info: LocaleKeys.goToSite.tr(),
                isTextOnly: true,
                onTap: () async {
                  if (itemData.item?.location?.latitude != null && itemData.item?.location?.longitude != null) {
                    await getIt<LocationService>().openLocationInMaps(
                      latitude: itemData.item!.location!.latitude!,
                      longitude: itemData.item!.location!.longitude!,
                    );
                  }
                },
              ),
              10.horizontalSpace,
            ],
          ),
          if (itemData.ui?.contacts?.numbers != null && itemData.ui!.contacts!.numbers!.isNotEmpty)
            ...itemData.ui!.contacts!.numbers!.map((number) {
              return Row(
                children: [
                  if (number.link != null && number.link!.isNotEmpty)
                    LinksItemDetials(
                      info: number.title ?? "",
                      svg: number.svg,
                      onTap: () {
                        launchURL(link: number.link!);
                      },
                    ),
                  if (number.link != null && number.link!.isNotEmpty) 10.horizontalSpace,
                ],
              );
            }),

          if (itemData.item?.social?.facebook != null)
            Row(
              children: [
                LinksItemDetials(
                  info: LocaleKeys.facebook.tr(),
                  onTap: () => launchURL(link: itemData.item!.social!.facebook!),
                ),
                if (itemData.item?.social?.facebook != null) 10.horizontalSpace,
              ],
            ),

          if (itemData.item?.social?.instagram != null)
            Row(
              children: [
                LinksItemDetials(
                  info: LocaleKeys.instagram.tr(),
                  onTap: () => launchURL(link: itemData.item!.social!.instagram!),
                ),
                if (itemData.item?.social?.instagram != null) 10.horizontalSpace,
              ],
            ),
        ],
      ),
    );
  }
}
