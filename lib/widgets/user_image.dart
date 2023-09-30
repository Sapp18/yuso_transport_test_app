import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserImage extends StatelessWidget {
  final String url;
  final double size;
  const UserImage(this.url, {super.key, this.size = 50});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
      ),
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: url == ''
            ? 'https://www.eleonoracardona.com/wp-content/uploads/2016/04/sin-foto.jpg'
            : url,
        errorWidget: (_, __, ___) => const Icon(Icons.error),
        placeholder: (_, __) => const CircularProgressIndicator(),
      ),
    );
  }
}
