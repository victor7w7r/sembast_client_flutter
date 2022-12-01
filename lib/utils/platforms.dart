import 'package:flutter/foundation.dart' show TargetPlatform, defaultTargetPlatform;

final isWindows = defaultTargetPlatform == TargetPlatform.windows;
final isLinux = defaultTargetPlatform == TargetPlatform.linux;
final isMacOS = defaultTargetPlatform == TargetPlatform.macOS;