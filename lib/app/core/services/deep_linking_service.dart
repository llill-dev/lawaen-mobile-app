import 'package:app_links/app_links.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lawaen/app/routes/router.gr.dart';

class DeepLinkService {
  static final appLinks = AppLinks();

  static Future<void> handleInitialLink(BuildContext context) async {
    final uri = await appLinks.getInitialLink();
    if (uri != null) {
      if (context.mounted) {
        _goToDeepLink(uri, context);
      }
    }
  }

  static void listenForLinks(BuildContext context) {
    appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri != null && context.mounted) _goToDeepLink(uri, context);
    });
  }

  static void _goToDeepLink(Uri uri, BuildContext context) {
    final segments = uri.pathSegments;

    if (segments.isNotEmpty && segments[0] == "item") {
      final subCategoryId = segments[1];
      final itemId = segments[2];

      context.router.push(CategoryItemDetialsRoute(subCategoryId: subCategoryId, itemId: itemId));
    }
  }
}
