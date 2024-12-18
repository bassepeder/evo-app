import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A provider that returns OS version of an Android device.
final androidVersionProvider =
    FutureProvider<AndroidBuildVersion?>((ref) async {
  if (!Platform.isAndroid) {
    return null;
  }

  final info = await DeviceInfoPlugin().androidInfo;
  return info.version;
});
