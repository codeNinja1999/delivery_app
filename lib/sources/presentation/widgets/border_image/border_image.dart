import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BorderImage extends StatelessWidget {
  const BorderImage({super.key, required this.imageUrl, this.size, this.borderColor});

  final String imageUrl;
  final double? size;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).colorScheme.secondaryContainer,
        border: Border.all(
          color: borderColor ?? Theme.of(context).colorScheme.tertiary,
          width: 1.0, // Adjust border width as needed
        ),
      ),
      child: ClipOval(
        child: SvgPicture.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
