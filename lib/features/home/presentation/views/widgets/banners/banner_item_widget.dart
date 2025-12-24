import 'package:flutter/material.dart';
import 'package:lawaen/app/core/functions/url_launcher.dart';
import 'package:lawaen/app/core/widgets/cached_image.dart';
import 'package:lawaen/app/core/widgets/skeletons/redacted_box.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/features/home/data/models/banner_model.dart';

class BannerItemWidget extends StatelessWidget {
  final BannerModel banner;
  final BorderRadius? borderRadius;
  final double? height;
  final BoxFit? fit;

  const BannerItemWidget({super.key, required this.banner, this.borderRadius, this.height, this.fit = BoxFit.cover});

  @override
  Widget build(BuildContext context) {
    final imageUrl = banner.image ?? '';

    final isGif = imageUrl.toLowerCase().endsWith('.gif');

    return GestureDetector(
      onTap: () {
        final goTo = banner.goTo;
        if (goTo != null && goTo.isNotEmpty && (goTo.startsWith('http://') || goTo.startsWith('https://'))) {
          launchURL(link: goTo);
        }
      },
      child: imageUrl.isNotEmpty
          ? isGif
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      imageUrl,
                      fit: fit ?? BoxFit.fill,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: ColorManager.primary,
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: ColorManager.lightGrey,
                          child: const Icon(Icons.broken_image, color: Colors.grey),
                        );
                      },
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedImage(url: imageUrl, fit: fit ?? BoxFit.fill),
                  )
          : SizedBox.shrink(),
    );
  }
}

class BannerItemSkeleton extends StatelessWidget {
  final double? height;
  final BorderRadius? borderRadius;

  const BannerItemSkeleton({super.key, this.height, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return RedactedBox(
      child: Container(
        width: double.infinity,
        height: height ?? 80,
        decoration: BoxDecoration(
          color: ColorManager.lightGrey,
          borderRadius: borderRadius ?? BorderRadius.circular(12),
        ),
      ),
    );
  }
}
