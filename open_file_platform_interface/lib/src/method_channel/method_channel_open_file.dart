import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../platform_interface/open_file_platform.dart';
import '../types/open_result.dart';

final MethodChannel _channel = MethodChannel('open_file');

/// An implementation of [OpenFilePlatform] that uses method channels.
class MethodChannelOpenFile extends OpenFilePlatform {
  /// The MethodChannel that is being used by this implementation of the plugin.
  @visibleForTesting
  MethodChannel get channel => _channel;

  @override
  Future<OpenResult> open(
    String? filePath, {
    String? type,
    bool isIOSAppOpen = false,
    String linuxDesktopName = "xdg",
    bool linuxUseGio = false,
    bool linuxByProcess = false,
  }) async {
    Map<String, dynamic> map = {
      "file_path": filePath!,
      "type": type,
      "isIOSAppOpen": isIOSAppOpen,
    };
    final result = await _channel.invokeMethod('open_file', map);
    final resultMap = json.decode(result) as Map<String, dynamic>;
    return OpenResult.fromJson(resultMap);
  }
}
