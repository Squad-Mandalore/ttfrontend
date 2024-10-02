import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ttfrontend/modules/widgets/custom_button.dart';
import 'package:ttfrontend/modules/widgets/custom_popup.dart';
import 'package:ttfrontend/pages/theme_selection/theme_provider/theme_provider.dart';
import 'package:ttfrontend/service/api_service.dart';

class ThemeSelectionPage extends StatelessWidget {
  const ThemeSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final selectedTheme = themeProvider.selectedTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Design Auswählen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButton<ThemeMode>(
              value: themeProvider.themeMode,
              onChanged: (ThemeMode? mode) {
                if (mode != null) {
                  themeProvider.setThemeMode(mode);
                }
              },
              items: const [
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text('System'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.light,
                  child: Text('Hell'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.dark,
                  child: Text('Dunkel'),
                ),
              ],
            ),
            const SizedBox(height: 30),
            CustomButton(
              buttonText: 'Telekom Funk',
              buttonColour: _getButtonColor(
                selectedTheme == 'TelekomFunk',
                themeProvider,
                'TelekomFunk',
              ),
              iconData: Icons.color_lens,
              buttonHeight: 60,
              buttonWidth: double.infinity,
              textSize: 18,
              borderColor: _getBorderColor(
                selectedTheme == 'TelekomFunk',
                themeProvider,
              ),
              onTap: () => themeProvider.setTheme('TelekomFunk'),
            ),
            const SizedBox(height: 20),
            CustomButton(
              buttonText: 'Schwerstarbeiter Braun',
              buttonColour: _getButtonColor(
                selectedTheme == 'HardworkingBrown',
                themeProvider,
                'HardworkingBrown',
              ),
              iconData: Icons.color_lens,
              buttonHeight: 60,
              buttonWidth: double.infinity,
              textSize: 18,
              borderColor: _getBorderColor(
                selectedTheme == 'HardworkingBrown',
                themeProvider,
              ),
              onTap: () => themeProvider.setTheme('HardworkingBrown'),
            ),
            const SizedBox(height: 20),
            CustomButton(
              buttonText: 'Bauern Blau',
              buttonColour: _getButtonColor(
                selectedTheme == 'PeasentBlue',
                themeProvider,
                'PeasentBlue',
              ),
              iconData: Icons.color_lens,
              buttonHeight: 60,
              buttonWidth: double.infinity,
              textSize: 18,
              borderColor: _getBorderColor(
                selectedTheme == 'PeasentBlue',
                themeProvider,
              ),
              onTap: () => themeProvider.setTheme('PeasentBlue'),
            ),
            const SizedBox(height: 20),
            CustomButton(
              buttonText: 'Landschafts Grün',
              buttonColour: _getButtonColor(
                selectedTheme == 'GrassyFields',
                themeProvider,
                'GrassyFields',
              ),
              iconData: Icons.color_lens,
              buttonHeight: 60,
              buttonWidth: double.infinity,
              textSize: 18,
              borderColor: _getBorderColor(
                selectedTheme == 'GrassyFields',
                themeProvider,
              ),
              onTap: () => themeProvider.setTheme('GrassyFields'),
            ),
            const SizedBox(height: 20),
            CustomButton(
              buttonText: 'Baumarkt Rot',
              buttonColour: _getButtonColor(
                selectedTheme == 'BaumarktRot',
                themeProvider,
                'BaumarktRot',
              ),
              iconData: Icons.color_lens,
              buttonHeight: 60,
              buttonWidth: double.infinity,
              textSize: 18,
              borderColor: _getBorderColor(
                selectedTheme == 'BaumarktRot',
                themeProvider,
              ),
              onTap: () => themeProvider.setTheme('BaumarktRot'),
            ),
            const SizedBox(height: 20),
            CustomButton(
              buttonText: "Schmidt's Handwerksbetrieb",
              buttonColour: _getButtonColor(
                selectedTheme == 'SchmidtBrand',
                themeProvider,
                'SchmidtBrand',
              ),
              iconData: Icons.color_lens,
              buttonHeight: 60,
              buttonWidth: double.infinity,
              textSize: 18,
              borderColor: _getBorderColor(
                selectedTheme == 'SchmidtBrand',
                themeProvider,
              ),
              onTap: () => themeProvider.setTheme('SchmidtBrand'),
            ),
            const Spacer(),
            CustomButton(
              buttonText: "Ausloggen",
              buttonColour: const Color(0xFFDE1A1A),
              iconData: Icons.logout_sharp,
              buttonHeight: 60,
              buttonWidth: double.infinity,
              textSize: 18,
              onTap: () => showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return GenericPopup(
                      title: 'Ausloggen',
                      agreeText: 'Ausloggen',
                      content:
                          const Text("Möchten Sie sich wirklich Ausloggen?"),
                      mode: PopUpMode.warning,
                      onAgree: () {
                        Navigator.of(context).pop();
                        ApiService.logout(context);
                      },
                      onDisagree: () {
                        Navigator.of(context).pop();
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Color _getButtonColor(
    bool isSelected,
    ThemeProvider themeProvider,
    String themeKey,
  ) {
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark ||
        (themeProvider.themeMode == ThemeMode.system &&
            WidgetsBinding.instance.platformDispatcher.platformBrightness ==
                Brightness.dark);

    final themeData = isDarkMode
        ? themeProvider.getDarkTheme(themeKey)
        : themeProvider.getLightTheme(themeKey);

    return isSelected
        ? themeData.colorScheme.primary
        : themeData.colorScheme.secondary;
  }

  Color _getBorderColor(bool isSelected, ThemeProvider themeProvider) {
    return isSelected ? Colors.white : Colors.transparent;
  }
}
