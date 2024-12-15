import 'package:evo/i18n/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> tryOpenUrlWithFeedback(String url, BuildContext context) async {
  if (!context.mounted) {
    return;
  }

  if (!await launchUrl(Uri.parse(url))) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(context.t.errors.failedToOpenUrl),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }
}
