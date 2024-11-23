import 'package:device_info_plus/device_info_plus.dart';
import 'package:evo/features/auth/providers/auth_session.dart';
import 'package:evo/features/auth/session_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'preloaded_data.g.dart';

typedef PreloadedData = ({
  PackageInfo packageInfo,
  BaseDeviceInfo deviceInfo,
  AuthSessionState? userSession,
});

@Riverpod(keepAlive: true)
Future<PreloadedData> preloadedData(Ref ref) async {
  final sessionStorage = ref.watch(sessionStorageProvider);

  final pInfo = await PackageInfo.fromPlatform();
  final deviceInfo = await DeviceInfoPlugin().deviceInfo;

  final userSession = await sessionStorage.read();

  return (
    packageInfo: pInfo,
    deviceInfo: deviceInfo,
    userSession: userSession,
  );
}
