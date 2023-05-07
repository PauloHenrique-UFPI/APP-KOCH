import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget{
  const CachedImage({Key? key, required this.imageUrl, this.circle = false}) : super(key: key);

  final String imageUrl;
  final bool circle;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: circle ? (context, imageProvider) => CircleAvatar(
        backgroundImage: imageProvider,
      ) : null, 
      progressIndicatorBuilder: (context, url, downloadProgress) => 
        CircularProgressIndicator(value: downloadProgress.progress),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        fadeInCurve: Curves.easeIn,
        fadeInDuration: const Duration(seconds: 1),
        
    );
  }
}