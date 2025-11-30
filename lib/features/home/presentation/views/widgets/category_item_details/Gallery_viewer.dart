import 'package:flutter/material.dart';
import 'package:lawaen/app/core/widgets/loading_widget.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class GalleryViewer extends StatelessWidget {
  final List<String> images;
  final int initialIndex;

  const GalleryViewer({super.key, required this.images, required this.initialIndex});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ColorManager.black.withValues(alpha: 0.9),
      insetPadding: EdgeInsets.zero,
      child: Stack(
        children: [
          PhotoViewGallery.builder(
            loadingBuilder: (context, event) {
              return Center(child: LoadingWidget());
            },
            pageController: PageController(initialPage: initialIndex),
            itemCount: images.length,
            builder: (context, index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: NetworkImage(images[index]),
                heroAttributes: PhotoViewHeroAttributes(tag: images[index]),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 2,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
              );
            },
            scrollPhysics: const BouncingScrollPhysics(),
            backgroundDecoration: const BoxDecoration(color: Colors.transparent),
          ),

          // CLOSE BUTTON
          Positioned(
            top: 40,
            right: 20,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.close, color: Colors.white, size: 28),
            ),
          ),
        ],
      ),
    );
  }
}
