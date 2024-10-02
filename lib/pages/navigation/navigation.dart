import 'package:flutter/material.dart';

void main() => runApp(const NavigationPageApp());

class NavigationPageApp extends StatelessWidget {
  const NavigationPageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const NavigationPage(),
    );
  }
}

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.transparent, // No background indicator color
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          iconTheme: WidgetStateProperty.resolveWith<IconThemeData>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.selected)) {
                return const IconThemeData(
                    color: Colors.blue); // Selected icon color
              }
              return const IconThemeData(
                  color: Colors.grey); // Unselected icon color
            },
          ),
        ),
        child: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          selectedIndex: currentPageIndex,
          destinations: const <NavigationDestination>[
            NavigationDestination(
              selectedIcon: Icon(Icons.calendar_month),
              icon: Icon(Icons.calendar_month),
              label: '?1',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.access_time),
              icon: Icon(Icons.access_time),
              label: 'Zeiten',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.format_list_bulleted),
              icon: Icon(Icons.format_list_bulleted),
              label: '?2',
            ),
          ],
        ),
      ),
      body: _getSelectedPage(),
    );
  }

  /// Return the selected page based on currentPageIndex
  Widget _getSelectedPage() {
    switch (currentPageIndex) {
      case 0:
        return const Center(
          child: Text('Home Page'),
        ); // Replace with your HomePage widget
      case 1:
        return const Center(
          child: Text('Notifications Page'),
        ); // Replace with your NotificationsPage widget
      case 2:
        return const Center(
          child: Text('Messages Page'),
        ); // Replace with your MessagesPage widget
      default:
        return const Center(
          child: Text('Home Page'),
        );
    }
  }
}
