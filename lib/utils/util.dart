import 'package:evo/i18n/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Attempts to open a URL and provides user feedback if it fails.
///
/// If the URL cannot be opened, a [SnackBar] is displayed with an error message.
///
/// - Parameters:
///   - [url]: The URL to be opened.
///   - [context]: The [BuildContext] used to show feedback.
///
/// - Returns: A [Future] that completes when the operation finishes.
Future<void> tryOpenUrlWithFeedback(String url, BuildContext context) async {
  if (!context.mounted) {
    return;
  }

  if (!await canLaunchUrl(Uri.parse(url))) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(context.t.errors.failedToOpenUrl),
          behavior: SnackBarBehavior.floating,
        ),
      );
  } else {
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
}
