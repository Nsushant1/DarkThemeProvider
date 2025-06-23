import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/theme_provider.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      themeMode: context.watch<ThemeProvider>().themeMode,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Theme Mode'),
        centerTitle: true,
        actions: [
          PopupMenuButton<ThemeMode>(
            icon: Icon(
              themeProvider.themeMode == ThemeMode.system
                  ? Icons.devices
                  : themeProvider.isDarkMode
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
            onSelected: (ThemeMode mode) {
              themeProvider.setThemeMode(mode);
            },
            itemBuilder:
                (context) => [
                  const PopupMenuItem(
                    value: ThemeMode.system,
                    child: Row(
                      children: [
                        Icon(Icons.devices),
                        SizedBox(width: 8),
                        Text('System Theme'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: ThemeMode.light,
                    child: Row(
                      children: [
                        Icon(Icons.light_mode),
                        SizedBox(width: 8),
                        Text('Light Theme'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: ThemeMode.dark,
                    child: Row(
                      children: [
                        Icon(Icons.dark_mode),
                        SizedBox(width: 8),
                        Text('Dark Theme'),
                      ],
                    ),
                  ),
                ],
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
              size: 64,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              'Current Theme Mode:',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              themeProvider.themeMode == ThemeMode.system
                  ? 'System (${themeProvider.isDarkMode ? "Dark" : "Light"})'
                  : themeProvider.themeMode == ThemeMode.dark
                  ? 'Dark'
                  : 'Light',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Tap the icon in the app bar to change theme',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
