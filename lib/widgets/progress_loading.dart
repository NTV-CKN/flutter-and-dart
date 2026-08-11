import 'dart:ui';

import 'package:flutter/material.dart';

void showDialogLoading(BuildContext ctx) {
  showDialog(
    barrierDismissible: false,
    fullscreenDialog: true,
    barrierColor: Colors.transparent,
    context: ctx,
    builder: (context) {
      return PopScope(
        canPop: false,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                'Loading...',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

void hideDialogLoading(BuildContext ctx) {
  Navigator.of(ctx, rootNavigator: true).pop();
}
