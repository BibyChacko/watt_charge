import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppImage {
  static Widget network(String url,{double width = 80.0, height = 80.0}) {
    return CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      placeholder: (_, __) => const CircularProgressIndicator(),
      errorWidget: (_, __, error) => const Icon(Icons.error),
    );
  }

  static Widget assets(String path,{double? width,double? height}){
    return Image.asset(path,width: width,height: height,fit: BoxFit.contain,);
  }
}
