import 'package:flutter/material.dart';

import '../../../core/app_core.dart';
import '../../widgets/widgets.dart';

class ImagePreviewPage extends StatelessWidget {
  const ImagePreviewPage({super.key, this.receiptImage});
  final String? receiptImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        backgroundColor: Theme.of(context).colorScheme.shadow,
        allowBack: false,
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.close,
              size: AppSize.spacedViewSpacing,
              color: Theme.of(context).colorScheme.surface,
            ),
          )
        ],
      ),
      backgroundColor: Colors.grey.withOpacity(0.9),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(AppSize.viewMargin),
        child: (receiptImage != null)
            ? AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                    // color: theme.colorScheme.tertiary,
                    // shape: BoxShape.circle,
                    image: DecorationImage(image: NetworkImage(receiptImage!), fit: BoxFit.cover),
                  ),
                ),
              )
            : const Icon(Icons.error),
      ),
    );
  }
}
