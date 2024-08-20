import 'package:flutter/material.dart';
import 'package:ttfrontend/assets/colours/extended_theme.dart';
import 'package:ttfrontend/pages/theme_selection/theme_selection_page.dart';
import 'package:ttfrontend/pages/timer/timer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 1; // Default to Zeitmanagement (page 1)
  final PageController _pageController =
      PageController(initialPage: 1); // Start on page 1

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index); // Navigate to the corresponding page
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Function to generate the dynamic app bar title
  Widget _buildAppBarTitle(int index) {
    switch (index) {
      case 0:
        return const Text('Zeitenübersicht');
      case 1:
        return const Text('Zeitmanagement');
      case 2:
        return const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: SearchBar()), // Replace with actual search widget
          ],
        );
      default:
        return const Text('How did you get here?');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customColors = theme.extension<CustomThemeExtension>();
    final customBackgroundColor = theme.colorScheme.secondary;
    final customIconColor =
        customColors?.primaryAccent1 ?? theme.colorScheme.primary;
    final unselectedIconColor = theme.colorScheme.onSurface;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: customBackgroundColor,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'lib/assets/images/squad_mandalore_original.png', // Your small image here
            width: 30,
            height: 30,
            fit: BoxFit.contain,
          ),
        ),
        title: _buildAppBarTitle(_selectedIndex), // Dynamic title based on page
        centerTitle: _selectedIndex == 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.palette),
            color: theme.colorScheme.onSurface,
            onPressed: () {
              // Navigate to theme selection page
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ThemeSelectionPage()),
              );
            },
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: const [
          Center(child: Text('Übersicht Page')),
          TimerPage(),
          Center(
              child: Text('Aufgaben Page')), // This one will have a search bar
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 80, // Custom height for the navbar
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          backgroundColor: customBackgroundColor, // Background color from theme
          selectedItemColor: customIconColor, // Icon color when selected
          unselectedItemColor:
              unselectedIconColor, // Icon color when not selected
          showSelectedLabels: true, // Only show the text when selected
          showUnselectedLabels: false, // Hide text when not selected
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: 'Übersicht',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.timer),
              label: 'Zeiten',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_task),
              label: 'Aufgaben',
            ),
          ],
          iconSize: 30, // Squad Mandalore Logo
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 14, // Font size when selected
          unselectedFontSize:
              0, // Set to 0 to effectively hide unselected labels
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
