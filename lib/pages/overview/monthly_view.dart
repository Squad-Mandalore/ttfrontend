import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ttfrontend/assets/colours/extended_theme.dart';
import 'package:ttfrontend/modules/widgets/custom_popup.dart';
import 'package:ttfrontend/pages/overview/utils/monthly_stats.dart';
import 'package:ttfrontend/pages/overview/utils/overview_logic.dart';
import 'package:ttfrontend/pages/overview/utils/pdf_generation.dart';
import 'package:ttfrontend/pages/theme_selection/theme_provider/theme_provider.dart';

class MonthviewContent extends StatefulWidget {
  final String formattedMonthYear;

  const MonthviewContent({super.key, required this.formattedMonthYear});

  @override
  MonthviewContentState createState() => MonthviewContentState();
}

class MonthviewContentState extends State<MonthviewContent> {
  String? arbeitszeit;
  String? fahrtzeit;
  String? totalTime;
  bool isGeneratingPdf = false; // Add a boolean to track PDF generation state

  @override
  void initState() {
    super.initState();
    _fetchMonthlyStats(context);
  }

  Future<void> _fetchMonthlyStats(BuildContext context) async {
    String formattedMonthYear = widget.formattedMonthYear;
    MonthlyStats monthlyStats = MonthlyStats();

    try {
      final times = await monthlyStats.getMonthlyStats(formattedMonthYear);
      final arbeitszeit = times['worktime'];
      final fahrtzeit = times['drivetime'];
      final totalTime = times['totalTime'];

      setState(() {
        this.arbeitszeit = arbeitszeit;
        this.fahrtzeit = fahrtzeit;
        this.totalTime = totalTime;
      });
    } catch (e) {
      if (context.mounted) {
        GenericPopup.showErrorPopup(context,
            'Es ist ein Fehler beim Laden der Daten aufgetreten. Bitte versuche es später erneut.');
      }
    }
  }

  Future<void> _generatePdf() async {
    setState(() {
      isGeneratingPdf = true; // Show the loading indicator
    });

    String themeKey =
        Provider.of<ThemeProvider>(context, listen: false).getCurrentThemeKey();

    try {
      await fetchAndSavePdf(widget.formattedMonthYear, themeKey, context);
    } finally {
      if (mounted) {
        setState(() {
          isGeneratingPdf = false; // Hide the loading indicator
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customColors = theme.extension<CustomThemeExtension>();

    return Column(
      children: [
        const SizedBox(height: 30),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          color: customColors?.backgroundAccent3 ?? theme.colorScheme.surface,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Aufgaben-Bearbeitungszeit'),
                    Text(
                      arbeitszeit ?? 'Lade...',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Fahrtzeit'),
                    Text(
                      fahrtzeit ?? 'Lade...',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Gesamt',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      totalTime ?? 'Lade...',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 30),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          color: customColors?.backgroundAccent3 ?? theme.colorScheme.surface,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                  child:
                      const Icon(Icons.self_improvement, color: Colors.white),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'zuletzt ausgestellt:',
                        style: TextStyle(
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 4),
                      FutureBuilder<String>(
                        future: OverviewLogic.getLastPdfRequest(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Text('Lade...');
                          } else if (snapshot.hasError) {
                            return const Text('Fehler beim Laden');
                          } else {
                            return Text(
                              snapshot.data ?? 'Keine Daten',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.onSurface,
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 30),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: isGeneratingPdf ? null : _generatePdf,
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16.0),
            ),
            child: isGeneratingPdf
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Text(
                    'PDF generieren',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
