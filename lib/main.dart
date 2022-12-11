import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharedprefs/screen.dart';
import 'cubit/theme_cubit.dart';
import 'cubit/theme_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            routes: {
              Screen.routeName: (context) => const Screen(),
            },
            theme: state.theme,
            home: const MyHomePage(title: 'SharedPrefs'),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String stroka = "";
  int theme = 0;
  late SharedPreferences sharedPreferences;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });

    sharedPreferences.setInt('counter', _counter);
  }
  

  @override
  Future<void> initShared() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey('counter') &&
        sharedPreferences.containsKey('stroka') &&
        sharedPreferences.containsKey('theme')) {
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, Screen.routeName, arguments: {
        'stroka1': sharedPreferences.getString('stroka'),
        'count': sharedPreferences.getInt('counter'),
        'theme': sharedPreferences.getInt('theme'),
      });
    }
  }

  @override
  void initState() {
    initShared().then((value) {
      _counter = sharedPreferences.getInt('counter') ?? 0;
      stroka = sharedPreferences.getString('stroka') ?? "";
      theme = sharedPreferences.getInt('theme') ?? 0;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              onChanged: (value) {
                sharedPreferences.setString('stroka', value);
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                icon: Icon(Icons.add_reaction_outlined),
                hintText: "Введите строку для записис в prefs",
              ),
            ),
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    Screen.routeName,
                    arguments: {
                      'stroka1': sharedPreferences.getString('stroka'),
                      'count': sharedPreferences.getInt('counter'),
                      'theme': sharedPreferences.getInt('theme'),
                    },
                  );
                },
                child: const Text("Передать аргументы")),
            const SizedBox(
              height: 100,
              width: 100,
            ),
            FloatingActionButton(
              onPressed: () {
                context.read<ThemeCubit>().switchTheme();
                if (context.read<ThemeCubit>().state.theme ==
                    ThemeData.light()) {
                  sharedPreferences.setInt('theme', 1);
                } else {
                  sharedPreferences.setInt('theme', 0);
                }
              },
              tooltip: 'Theme',
              child: const Icon(Icons.thermostat),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
