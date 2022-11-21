import 'package:flutter/foundation.dart' show TargetPlatform, defaultTargetPlatform, kIsWeb;

final isDesktop = defaultTargetPlatform == TargetPlatform.linux
  || defaultTargetPlatform == TargetPlatform.macOS
  || defaultTargetPlatform == TargetPlatform.windows;

final isWindows = defaultTargetPlatform == TargetPlatform.windows;
final isLinux = defaultTargetPlatform == TargetPlatform.linux;
final isMacOS = defaultTargetPlatform == TargetPlatform.macOS;

final isAndroid = defaultTargetPlatform == TargetPlatform.android;
final isIos = defaultTargetPlatform == TargetPlatform.iOS;
const isWeb = kIsWeb;

final isMobile = isAndroid || isIos;


