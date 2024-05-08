import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MenuItem {
  final String title;
  final IconData icon;
  final String route;

  MenuItem({required this.title, required this.icon, required this.route});
}

final menuItems = <MenuItem>[
  MenuItem(title: 'Giróscopio', icon: Icons.downloading, route: '/gyroscope'),
  MenuItem(title: 'Acelerómetro', icon: Icons.speed, route: '/accelerometer'),
  MenuItem(
      title: 'Magnetómetro',
      icon: Icons.explore_outlined,
      route: '/magnetometer'),
  MenuItem(
      title: 'Giróscopio Ball',
      icon: Icons.sports_baseball_outlined,
      route: '/gyroscope-ball'),
  MenuItem(title: 'Brújula', icon: Icons.explore, route: '/compass'),
  MenuItem(
      title: 'Pokemons',
      icon: Icons.catching_pokemon_outlined,
      route: '/pokemons'),
  MenuItem(title: 'Biométricos', icon: Icons.fingerprint, route: '/biometrics'),
  MenuItem(
      title: 'Ubicación', icon: Icons.location_on_outlined, route: '/location'),
  MenuItem(title: 'Mapas', icon: Icons.map_outlined, route: '/maps'),
  MenuItem(
      title: 'Controlado',
      icon: Icons.control_camera_rounded,
      route: '/controlled-map'),
  MenuItem(title: 'Badge', icon: Icons.notifications, route: '/badge'),
  MenuItem(
      title: 'Ad Full', icon: Icons.ad_units_rounded, route: '/ad-fullscreen'),
  MenuItem(title: 'Ad Reward', icon: Icons.fort_rounded, route: '/ad-rewarded'),
];

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverGrid.count(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: menuItems
            .map((item) => HomeMenuItem(
                  icon: item.icon,
                  route: item.route,
                  title: item.title,
                ))
            .toList());
  }
}

class HomeMenuItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final String route;
  final List<Color> bgColors;

  const HomeMenuItem(
      {super.key,
      required this.title,
      required this.icon,
      required this.route,
      this.bgColors = const [Colors.lightBlue, Colors.blue]});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(route),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
                colors: bgColors,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 40),
            const SizedBox(height: 10),
            Text(title,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
