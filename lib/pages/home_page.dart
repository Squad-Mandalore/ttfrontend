import 'package:flutter/material.dart';
import 'package:ttfrontend/assets/colours/extended_theme.dart';
import 'package:ttfrontend/pages/aufgaben/tasks.dart';
import 'package:ttfrontend/pages/theme_selection/theme_selection_page.dart';
import 'package:ttfrontend/pages/timer/debug_clear_prefs.dart';
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
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  List<Task> tasks = [
    Task(id: '1', name: 'Test Task'),
    Task(id: '2', name: 'Test Task 2'),
    Task(id: '3', name: 'Test Task 3'),
    Task(id: '4', name: 'Test Task 4 with a very long title'),
    Task(id: '4', name: 'Test Task 4 with a very long title'),
    Task(id: '4', name: 'Test Task 4 with a very long title'),
    Task(id: '4', name: 'Test Task 4 with a very long title'),
    Task(id: '4', name: 'Test Task 4 with a very long title'),
    Task(id: '4', name: 'Test Task 4 with a very long title'),
    Task(id: '4', name: 'Test Task 4 with a very long title'),
    Task(id: '4', name: 'Test Task 4 with a very long title'),
  ];

  String _searchQuery = '';

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _isSearching = false; // Reset search state on page change
    });
    _pageController.jumpToPage(index);
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
      _isSearching = false; // Reset search state on page change
    });
  }

  Widget _buildAppBarTitle(int index, Color textColor) {
    if (index == 2) {
      if (_isSearching) {
        return Stack(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Suche Aufgaben',
                hintStyle: TextStyle(color: Colors.grey[600], fontSize: 18),
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              ),
              style: const TextStyle(color: Colors.black, fontSize: 18),
              onChanged: (query) {
                setState(() {
                  _searchQuery = query;
                });
              },
              autofocus: true,
            ),
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: IconButton(
                icon: const Icon(Icons.clear, size: 20),
                color: Colors.black,
                onPressed: () {
                  setState(() {
                    _isSearching = false;
                    _searchController.clear();
                    _searchQuery = '';
                  });
                },
              ),
            ),
          ],
        );
      } else {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Aufgaben',
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (tasks.length > 1)
              IconButton(
                icon: const Icon(Icons.search),
                color: textColor,
                onPressed: () {
                  setState(() {
                    _isSearching = true;
                  });
                },
              ),
          ],
        );
      }
    }

    switch (index) {
      case 0:
        return Text(
          'Zeitenübersicht',
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        );
      case 1:
        return Text(
          'Zeitmanagement',
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        );
      default:
        return const Text('How did you get here?');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customColors = theme.extension<CustomThemeExtension>();
    final customBackgroundColor = theme.colorScheme.primary;
    final customIconColor = theme.colorScheme.onPrimary;
    final unselectedIconColor =
        customColors?.primaryAccent6 ?? theme.colorScheme.onPrimary;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: customColors?.headerColor ?? customBackgroundColor,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'lib/assets/images/squad_mandalore_original.png',
            width: 30,
            height: 30,
            fit: BoxFit.contain,
          ),
        ),
        title: _buildAppBarTitle(_selectedIndex,
            theme.colorScheme.onPrimary), // Dynamic title based on page
        centerTitle: _selectedIndex == 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.palette),
            color: theme.colorScheme.onPrimary,
            onPressed: () {
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
        children: [
          const DebugClearPrefsButton(),
          const TimerPage(),
          TaskPage(
              tasks: tasks, searchQuery: _searchQuery), // Pass search query
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 80, // Custom height for the navbar
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          backgroundColor: customColors?.headerColor ?? customBackgroundColor,
          selectedItemColor: customIconColor,
          unselectedItemColor: unselectedIconColor,
          showSelectedLabels: true,
          showUnselectedLabels: false,
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
          iconSize: 30, // Icon size
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 14, // Font size when selected
          unselectedFontSize: 0, // Set to 0 to hide unselected labels
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _pageController.dispose();
    super.dispose();
  }
}
