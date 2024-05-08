import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:miscelaneos/config/config.dart';

final adBannerProvider = FutureProvider<BannerAd>((ref) async {
  // Todo: Validar si se muestran o no los anuncios

  final ad = await AdmobPlugin.loadBannerAd();

  return ad;
});

final adInterstitialProvider =
    FutureProvider.autoDispose<InterstitialAd>((ref) async {
  // Todo: Validar si se muestran o no los anuncios

  final ad = await AdmobPlugin.loadInterstititalAd();

  return ad;
});
