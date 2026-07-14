import 'package:flutter/material.dart';

class ImageCustomWidget extends StatelessWidget {
  static const assetsOption = 'assetsOption';

  final String option;
  final String source;

  const ImageCustomWidget.option({
    super.key,
    required this.option,
    required this.source,
  });

  @override
  Widget build(BuildContext context) {
    Image image;

    if (option == assetsOption) {
      image = Image.asset(
        source,
        width: 200,
        height: 200,
      );
    } else {
      throw Exception('Not found option');
    }

    return image;
  }
}
