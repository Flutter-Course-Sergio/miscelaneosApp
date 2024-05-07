import 'package:quick_actions/quick_actions.dart';

import '../config.dart';

class QuickActionsPlugin {
  static registerActions() {
    const QuickActions quickActions = QuickActions();

    quickActions.initialize((shortcutType) {
      switch (shortcutType) {
        case 'biometric':
          router.push('/biometrics');
          break;
        case 'compass':
          router.push('/compass');
          break;
        case 'pokemons':
          router.push('/pokemons');
          break;
        case 'charmander':
          router.push('/pokemons/4');
          break;
      }
    });

    quickActions.setShortcutItems(<ShortcutItem>[
      const ShortcutItem(type: 'biometric', localizedTitle: 'Biometric'),
      const ShortcutItem(type: 'compass', localizedTitle: 'Compass'),
      const ShortcutItem(type: 'pokemons', localizedTitle: 'Pokemons'),
      const ShortcutItem(type: 'charmander', localizedTitle: 'Charmander'),
    ]);
  }
}
