import 'package:event_planr_app/env/env.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherUtils {
  static Future<void> openMap(double latitude, double longitude) async {
    final googleUrl = Uri.parse(
            'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude',
          );
    await launchUrl(googleUrl);
  }

  static Future<void> downloadAndroidApk() async {
    final androidApkUrl = Uri.parse(Env.androidApkUrl);
    await launchUrl(androidApkUrl);
  }
}
