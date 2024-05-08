import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

final adBannerId = Platform.isAndroid
    ? 'ca-app-pub-3940256099942544/6300978111'
    : 'ca-app-pub-3940256099942544/2934735716';

class AdmobPlugin {
  static Future<void> initAdMob() async {
    await MobileAds.instance.initialize();
  }

  static Future<BannerAd> loadBannerAd() async {
    return BannerAd(
        adUnitId: adBannerId,
        request: const AdRequest(),
        size: AdSize.banner,
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            print('$ad loaded');
          },
          onAdFailedToLoad: (ad, error) {
            print('BannerAd failed to load: $error');
            ad.dispose();
          },
        ))
      ..load();
  }
}
