import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sippy_cart_sharing/common_widgets/animated_loader.dart';

/// Custom image widget that loads an image as a static asset or uses
/// [CachedNetworkImage] depending on the image URL.
class CustomImage extends StatelessWidget {
  const CustomImage({super.key, required this.imageUrl});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child:
          imageUrl.startsWith('http')
              ? CachedNetworkImage(
                imageUrl: localhostFriendlyImageUrl,
                placeholder:
                    (context, url) =>
                        const Center(child: CustomLoadingIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              )
              : Image.asset(imageUrl),
    );
  }

  String get localhostFriendlyImageUrl {
    const localhostDefault1 = 'http://127.0.0.1';
    const localhostDefault2 = 'http://localhost';
    const localhostAndroid = 'http://10.0.2.2';

    final isAndroid = !kIsWeb && Platform.isAndroid;

    if (isAndroid) {
      if (imageUrl.startsWith(localhostDefault1)) {
        return imageUrl.replaceFirst(localhostDefault1, localhostAndroid);
      } else if (imageUrl.startsWith(localhostDefault2)) {
        return imageUrl.replaceFirst(localhostDefault2, localhostAndroid);
      }
    } else if (imageUrl.startsWith(localhostAndroid)) {
      return imageUrl.replaceFirst(localhostAndroid, localhostDefault1);
    }

    return imageUrl;
  }
}
