import 'dart:io';

/// Keep backend URLs as-is but map `0.0.0.0` to the Android emulator loopback
/// so images remain reachable on device while still using the original endpoint.
String? makeDeviceAccessibleUrl(String? url) {
  if (url == null) return null;
  if (!url.contains('0.0.0.0')) return url;

  try {
    if (Platform.isAndroid) {
      return url.replaceFirst('0.0.0.0', '10.0.2.2');
    }
  } catch (_) {
    // If Platform checks fail (e.g. web), leave the URL unchanged.
  }

  return url;
}
