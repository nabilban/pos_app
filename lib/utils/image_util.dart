import 'dart:convert';
import 'package:flutter/material.dart';

class ImageUtil {
  /// Builds an [Image] widget based on the format of [imageSource].
  /// Supports Base64 data URIs, network URLs, and local assets.
  static Widget buildImage(
    String imageSource, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    Widget? errorWidget,
  }) {
    // 1. Base64 Data URI
    if (imageSource.startsWith('data:image/')) {
      try {
        final base64String = imageSource.split(',').last;
        final bytes = base64Decode(base64String);
        return Image.memory(
          bytes,
          width: width,
          height: height,
          fit: fit,
          errorBuilder: (context, error, stackTrace) =>
              errorWidget ?? _defaultErrorWidget(),
        );
      } catch (e) {
        return errorWidget ?? _defaultErrorWidget();
      }
    }

    // 2. Network URL
    if (imageSource.startsWith('http')) {
      return Image.network(
        imageSource,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) =>
            errorWidget ?? _defaultErrorWidget(),
      );
    }

    // 3. Local Asset
    return Image.asset(
      imageSource,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) =>
          errorWidget ?? _defaultErrorWidget(),
    );
  }

  static Widget _defaultErrorWidget() {
    return const Center(
      child: Icon(
        Icons.broken_image_outlined,
        color: Color(0xFF94A3B8),
        size: 24,
      ),
    );
  }
}
