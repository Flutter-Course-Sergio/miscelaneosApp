import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/config/config.dart';

const storeKey = 'showAds';

class ShowAddNotifier extends StateNotifier<bool> {
  ShowAddNotifier() : super(false) {
    checkAdsState();
  }

  void checkAdsState() async {
    state = await SharedPreferencesPlugin.getBool(storeKey) ?? true;
  }

  void removeAds() {
    SharedPreferencesPlugin.setBool(storeKey, false);
    state = false;
  }

  void showAds() {
    SharedPreferencesPlugin.setBool(storeKey, true);
    state = true;
  }

  void toggleAds() {
    state ? removeAds() : showAds();
  }
}

final showAdsProvider = StateNotifierProvider<ShowAddNotifier, bool>((ref) {
  return ShowAddNotifier();
});
