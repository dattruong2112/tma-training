import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en'); // Default to English

  void _toggleLanguage(bool lang) {
    setState(() {
      _locale = lang ? const Locale('vi') : const Locale('en');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      title: 'Flutter Demo',
      locale: _locale,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: MyHomePage(
        onToggleLanguage: _toggleLanguage,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final void Function(bool) onToggleLanguage;

  const MyHomePage({super.key, required this.onToggleLanguage});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool lang = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: Theme.of(context)
            .textTheme
            .titleLarge
            ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(S.of(context).title),
        actions: [
          Switch(
            value: lang,
            onChanged: (value) {
              setState(() {
                lang = value;
                widget.onToggleLanguage(lang);
              });
            },
          ),
        ],
      ),
      body: Center(
        child: Text(
          S.of(context).helloWorld,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
