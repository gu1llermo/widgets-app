import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:widgets_app/config/menu/menu_item.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key, required this.scaffoldKey});

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  int navDrawerIndex = 0;

  @override
  Widget build(BuildContext context) {
    final hasNotch = MediaQuery.of(context).viewPadding.top > 35;
    // print('viewPadding.top: $hasNotch');

    return NavigationDrawer(
        selectedIndex: navDrawerIndex,
        onDestinationSelected: (value) {
          setState(() {
            navDrawerIndex = value;
          });
          final menuItem = appMenuItems[value];
          context.push(menuItem.link);
          widget.scaffoldKey.currentState?.closeDrawer();
          // ese signo de interrogación, lo que significa es que verifica si es null
          // antes de hacer su llamada, si es null no hace nada, hace la llamada solo
          // si es distinto de null, es como una garantía
          // ?. es un checknull operator
        },
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(28, hasNotch ? 0 : 20, 16, 10),
            child: const Text('Main'),
          ),
          ...appMenuItems.sublist(0, 3).map((item) {
            return NavigationDrawerDestination(
                icon: Icon(item.icon), label: Text(item.title));
          }),
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
            child: Divider(),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 10, 16, 10),
            child: Text('More options'),
          ),
          ...appMenuItems.sublist(3).map((item) {
            return NavigationDrawerDestination(
                icon: Icon(item.icon), label: Text(item.title));
          }),
        ]);
  }
}
